<template lang="pug">
div
  .text-center.alert.alert-danger(v-if="loadError") {{loadError}}
  .text-center(v-else-if="beers.length === 0")
    loading-bars
  table-component(v-else :data="beers" sort-by="abv" sort-order="desc" tableClass="table table-striped table-sm" countLabel="beer" filterNoResults="")
    table-column(show="title" label="Name")
    table-column(show="origin" label="From")
    table-column(show="style" label="Style")
    table-column(show="abv" label="ABV" v-bind:formatter="formatABV" data-type="numeric")
</template>

<script lang="coffee">
export default
  data: ->
    beers: []
    loadError: null

  props:
    getBeers:
      type: Function
      required: true

  created: ->
    @getBeers()
      .then (beers) =>
        beers.forEach (b) ->
          b.abv = null if isNaN(b.abv)
        @beers = beers
      .catch (err) =>
        @loadError = err.message

  methods:
    formatABV: (v) -> if (v is null or isNaN(v)) then 'Varies' else v.toFixed(1) + '&nbsp;%'
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
