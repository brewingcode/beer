import axios from 'axios'
import cheerio from 'cheerio'

export default ->
  axios.get 'https://www.brewingcode.net/beerproxy.php?brouwers'
    .then (res) =>
      $ = cheerio.load(res.data)
      section = ''
      type = 'Beer'

      $('.entry-content').children().map ->
        if this.tagName is 'p' and $('.item', this)
          $('.price', this).remove()
          # an individual beer
          text = $(this).text().trim()
          re = ///
            ^(.*?)
            \(
            ([\d\.]+)
            \s*%\)
            (.*)
          ///
          if m = text.match(re)
            from = if m[3] and section
              "#{m[3]}, #{section}"
            else if m[3]
              m[3]
            else
              ''

            return
              title: m[1]
              tags: []
              style: type
              abv: parseFloat(m[2])
              origin: from

          else if text and not /\d+\/\d+\/\d+/.test(text)
            return
              title: text
              tags: []
              style: type
              abv: null
              origin: null
          else
            console.warn 'parse failure:', text

        else
          text = $(this).text().trim()
          if /^cider/i.test(text)
            type = 'Cider'
            section = ''
          else if text.length < 15
            section = text
          else
            section = ''

        # return a valid object only on beer rows (see above)
        return null
      .get()
      .filter (b) -> b

    .catch (err) =>
      console.error err
      message = "error loading beers for brouwers: "
      if err.response
        message += err.response.data
      else
        message += err.message
      throw new Error message
