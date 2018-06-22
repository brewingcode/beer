import axios from 'axios'
import cheerio from 'cheerio'

export default ->
  axios.get 'https://www.brewingcode.net/beerproxy.php?yardhouse'
    .then (res) =>
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

    .catch (err) =>
      console.error err
      message = "error loading beers for yardhouse: "
      if err.response
        message += err.response.data
      else
        message += err.message
      throw new Error message
