import cheerio from 'cheerio'
import get from './get.coffee'

export default ->
  get('chucks-cd').then (res) ->
    $ = cheerio.load(res.data)

    $('.taplist-table tbody tr').map ->
      td = $('td', this).map( -> $(this).text() ).get()
      return
        title: td[0] + ' ' + td[1]
        tags: []
        style: td[2]
        abv: parseFloat td[6].replace(/[%\s]/g, '')
        origin: td[5]
    .get()
