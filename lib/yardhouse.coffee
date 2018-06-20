import axios from 'axios'
import cheerio from 'cheerio'

export default (vue) ->
  axios.get 'https://www.brewingcode.net/yardhouse.php?1'
    .then (res) =>
      $ = cheerio.load(res.data)
      vue.beers = $('.menu_item').map ->
        title: $('.beerlink', this).text()
        tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
        style: $('.beer-style', this).text()
        abv: parseFloat $('.beer-abv', this).text().replace(/^ABV\s+/, '').replace(/[%\s]/g, '')
        origin: $('.beer-origin', this).text()
      .get()
      .filter (b) -> b.title

      vue.beers.forEach (b) ->
        if b.tags.length
          b.title += ' ' + b.tags.map (tag) ->
            "<span class=\"tag alert alert-success strong\">#{tag.toLowerCase()}</span>"
          .join(' ')

      if not vue.beers.length
        vue.loadError = 'no beers found from yardhouse.com'

    .catch (err) =>
      console.error 'error getting live view of beer list'
      vue.loadError = "error loading beers from yardhouse.com: "
      if err.response.data
        vue.loadError += err.response.data
      else
        vue.loadError == "no response from server"
