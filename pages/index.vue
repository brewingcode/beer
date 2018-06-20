<template lang="pug">
div
  .text-center(v-if="beers.length === 0")
    loading-bars
  .text-center.alert.alert-danger(v-else-if="loadError") {{loadError}}
  table-component(v-else :data="beers" sort-by="style" tableClass="table table-striped table-sm" countLabel="beer" filterNoResults="")
    table-column(show="title" label="Name")
    table-column(show="origin" label="City")
    table-column(show="style" label="Style")
    table-column(show="abv" label="ABV" v-bind:formatter="formatABV" data-type="numeric")
</template>

<script lang="coffee">
import axios from 'axios'
import cheerio from 'cheerio'
import { TableComponent, TableColumn } from 'vue-table-component'
import LoadingBars from '~/components/LoadingBars'

export default
  components: { TableComponent, TableColumn, LoadingBars }

  data: ->
    beers: []
    loadError: null

  created: ->
    axios.get 'https://www.brewingcode.net/yardhouse.php?1'
      .then (res) =>
        $ = cheerio.load(res.data)
        @beers = $('.menu_item').map ->
          title: $('.beerlink', this).text()
          tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
          style: $('.beer-style', this).text()
          abv: parseFloat $('.beer-abv', this).text().replace(/^ABV\s+/, '').replace(/[%\s]/g, '')
          origin: $('.beer-origin', this).text()
        .get()
        .filter (b) -> b.title

        @beers.forEach (b) ->
          if b.tags.length
            b.title += ' ' + b.tags.map (tag) ->
              "<span class=\"tag alert alert-success strong\">#{tag.toLowerCase()}</span>"
            .join(' ')

        if not @beers.length
          @loadError = 'no beers found from yardhouse.com'

      .catch (err) =>
        console.error 'error getting live view of beer list'
        @loadError = "error loading beers from yardhouse.com: "
        if err.response.data
          @loadError += err.response.data
        else
          @loadError == "no response from server"

  methods:
    formatABV: (v) -> if (v is null or isNaN(v)) then 'Varies' else v.toFixed(1) + ' %'
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
.tag
  border-radius: 99px
  padding: 0 7px
  font-size: 75%
</style>
