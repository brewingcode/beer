<template lang="pug">
table-component(:data="beers" sort-by="style" tableClass="table table-striped table-sm")
  table-column(show="title" label="Name")
  table-column(show="style" label="Style")
  table-column(show="abv" label="ABV")
</template>

<script lang="coffee">
import axios from 'axios'
import cheerio from 'cheerio'
import { TableComponent, TableColumn } from 'vue-table-component'

export default
  components: { TableComponent, TableColumn }
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
