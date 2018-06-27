import cheerio from 'cheerio'
import get from './get.coffee'

export default ->
  get('rheinhaus').then (res) ->
    $ = cheerio.load(res.data)

    $('.beer-details').map ->
      return
        title: $('.brewery', this).text().trim() + ' ' + $('.beer-name a', this).text().trim()
        tags: []
        style: $('.beer-style', this).text().trim()
        abv: parseFloat $('.abv', this).text().replace(/[a-z%\s]/gi, '')
        origin: $('.location', this).text().trim()
    .get()
