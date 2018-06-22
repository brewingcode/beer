import axios from 'axios'
import cheerio from 'cheerio'

export default ->
  axios.get 'https://www.brewingcode.net/beerproxy.php?brouwers'
    .then (res) =>
      $ = cheerio.load(res.data)
      section = ''
      type = 'Beer'

      $('.entry-content > *').map ->
        if $('.item', this)
          $('.price', this).remove()
          # an individual beer
          text = $(this).text()
          re = ///
            ^(.*?)
            \(
            ([\d\.]+)
            %\)
            (.*)
          ///
          if m = text.match(re)
            city = if m[2] then "#{m[2]}, " else ''
            return
              title: m[1]
              tags: []
              style: type
              abv: parseFloat(m[2])
              origin: "#{city}#{m[3]}"
        else if $('.sectionName', this)
          text = $(this).text()
          if /^cider/i.test(text)
            type = 'Cider'
          else if text.length < 15
            section = text
          else
            section = ''

        # return a valid object only on beer rows (see above)
        return null
      .get()
      .filter (b) ->
        b.title

    .catch (err) =>
      console.error err
      message = "error loading beers for brouwers: "
      if err.response
        message += err.response.data
      else
        message += err.message
      throw new Error message
