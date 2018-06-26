import axios from 'axios'
import cheerio from 'cheerio'
import error from './error.coffee'

export default ->
  axios.get process.env.beerproxy + 'pinebox'
    .then (res) =>
      $ = cheerio.load(res.data)

      beers = $('#draft_list tr').map ->
        title = $('.draft_brewery', this).text() + ' ' + $('.draft_name', this).text()
        title: title
        tags: []
        style: if /cider/i.test(title) then 'Cider' else 'Beer'
        abv: parseFloat $('.draft_abv', this).text().replace(/[%\s]/g, '')
        origin: $('.draft_origin', this).text()
      .get()
      .filter (b) ->
        b.title

      return beers

    .catch error
