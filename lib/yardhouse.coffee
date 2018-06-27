import cheerio from 'cheerio'
import get from './get.coffee'

export default ->
  get('yardhouse').then (res) ->
    $ = cheerio.load(res.data)

    beers = $('.menu_item').map ->
      title: $('.beerlink', this).text()
      tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
      style: $('.beer-style', this).text()
      abv: parseFloat $('.beer-abv', this).text().replace(/^ABV\s+/, '').replace(/[%\s]/g, '')
      origin: $('.beer-origin', this).text()
    .get()
    .filter (b) ->
      b.title

    beers.forEach (b) ->
      if b.tags.length
        b.title += ' ' + b.tags.map (tag) ->
          "<span class=\"tag alert alert-success strong\">#{tag.toLowerCase()}</span>"
        .join(' ')

    return beers
