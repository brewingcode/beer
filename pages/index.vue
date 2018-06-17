<template lang="pug">
table.table.table-striped
  thead: tr
    th Name
    th Style
    th ABV
  tbody
    tr.beer(v-for="beer in beers")
      td {{beer.title}}
      td {{beer.style}}
      td {{beer.abv}}
</template>

<script lang="coffee">
import axios from 'axios'
import cheerio from 'cheerio'

export default
  asyncData: ->
    axios.get 'https://www.brewingcode.net/yardhouse.php?'
      .then (res) ->
        $ = cheerio.load(res.data)
        beers: $('.menu_item').map ->
          title: $('.beerlink', this).text()
          tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
          style: $('.beer-style', this).text()
          abv: $('.beer-abv', this).text().replace(/^ABV\s+/, '')
          origin: $('.beer-origin', this).text()
        .get()
        .filter (b) -> b.title

      .catch (err) ->
        console.error 'error getting live view of beer list'
        beers: []
</script>
