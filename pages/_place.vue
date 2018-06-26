<template lang="pug">
.container-fluid
  b-navbar(toggleable="md" variant="light")
    b-navbar-toggle(target="nav_collapse")
    b-navbar-brand.d-md-none(href="#") {{$route.params.place}}
    b-navbar-brand.d-none.d-md-inline-block(href="#") Beer
    b-collapse#nav_collapse(is-nav)
      b-navbar-nav
        b-nav-item(v-for="v,k of places" :to="'/'+k" :key="k") {{k}}
  beer-list(:getBeers="getBeers")
  footer.text-center
    a(href="https://github.com/brewingcode/beer") code on github.com
    br
    small: a(:href="'https://github.com/brewingcode/beer/commit/'+gitrev") {{gitrev}}
</template>

<script lang="coffee">
import yardhouse from '~/lib/yardhouse.coffee'
import pinebox from '~/lib/pinebox.coffee'
import brouwers from '~/lib/brouwers.coffee'
import chucksg from '~/lib/chucks-greenwood.coffee'
import chuckscd from '~/lib/chucks-cd.coffee'

places = {
  yardhouse
  pinebox
  brouwers
  'chucks-greenwood': chucksg
  'chucks-cd': chuckscd
}

export default
  data: ->
    places: places
    gitrev: process.env.gitrev
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
footer
  margin-bottom: 1em
</style>
