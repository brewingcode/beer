import cheerio from 'cheerio'
import get from './get.coffee'

export default ->
  get('chucks-green').then (res) ->
    $ = cheerio.load(res.data)

    $('tr').map ->
      if $(this).hasClass('draft_even') or $(this).hasClass('draft_odd')
        $(this).removeClass('draft_even draft_odd')
        return
          title: $('.draft_brewery', this).text() + ' ' + $('.draft_name', this).text()
          tags: []
          style: $(this).attr('class') or ''
          abv: parseFloat $('.draft_abv', this).text().replace(/[%\s]/g, '')
          origin: $('.draft_origin', this).text()
    .get()
    .filter (b) -> b
