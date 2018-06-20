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
import { TableComponent, TableColumn } from 'vue-table-component'
import LoadingBars from '~/components/LoadingBars'

export default
  components: { TableComponent, TableColumn, LoadingBars }

  data: ->
    beers: []
    loadError: null

  props:
    getBeers:
      type: Function
      required: true

  created: ->
    @getBeers(this)

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
