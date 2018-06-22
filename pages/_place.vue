<template lang="pug">
.container-fluid
  b-navbar(toggleable="sm" variant="light")
    b-navbar-toggle(target="nav_collapse")
    b-navbar-brand(href="#") Beer
    b-collapse#nav_collapse(is-nav)
      b-navbar-nav
        b-nav-item(v-for="v,k of places" :to="'/'+k" :key="k") {{k}}
  beer-list(:getBeers="getBeers")
  footer.text-center
    a(href="https://github.com/brewingcode/beer") github.com
</template>

<script lang="coffee">
import yardhouse from '~/lib/yardhouse.coffee'
import pinebox from '~/lib/pinebox.coffee'
import brouwers from '~/lib/brouwers.coffee'

places = {
  yardhouse
  pinebox
  brouwers
}

export default
  data: ->
    places: places
  computed:
    getBeers: ->
      places[@$route.params.place]
  validate: ({params}) ->
    places[params.place]
  head: ->
    title: 'Beer: ' + @$route.params.place
</script>

<style lang="stylus">
.navbar
  margin-bottom: 10px
</style>
