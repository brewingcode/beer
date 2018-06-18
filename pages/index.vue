<template lang="pug">
table-component(:data="beers" sort-by="style" tableClass="table table-striped table-sm" countLabel="beer" filterNoResults="")
  table-column(show="title" label="Name")
  table-column(show="origin" label="City")
  table-column(show="style" label="Style")
  table-column(show="abv" label="ABV" v-bind:formatter="formatABV" data-type="numeric")
</template>

<script lang="coffee">
import axios from 'axios'
import cheerio from 'cheerio'
import { TableComponent, TableColumn } from 'vue-table-component'

export default
  components: { TableComponent, TableColumn }
  asyncData: ->
    axios.get 'https://www.brewingcode.net/yardhouse.php?1'
      .then (res) ->
        $ = cheerio.load(res.data)
        beers: $('.menu_item').map ->
          title: $('.beerlink', this).text()
          tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
          style: $('.beer-style', this).text()
          abv: parseFloat $('.beer-abv', this).text().replace(/^ABV\s+/, '').replace(/[%\s]/g, '')
          origin: $('.beer-origin', this).text()
        .get()
        .filter (b) -> b.title

      .catch (err) ->
        console.error 'error getting live view of beer list'
        beers: []
  methods:
    formatABV: (v) -> if v is null then 'Varies' else v.toFixed(1) + ' %'
</script>

<style lang="stylus">
.table-component__th
  cursor: pointer
.table-component__th--sort-asc::after
  content: "↑"
.table-component__th--sort-desc::after
  content: "↓"
.table-component__filter__clear
  cursor: pointer
</style>
