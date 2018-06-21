<template lang="pug">
.container-fluid
  nav.navbar.navbar-expand-lg.navbar-light.bg-light
    span.navbar-brand {{place}}
    button.navbar-toggler(
      type="button"
      data-toggle="collapse"
      data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation")
      span.navbar-toggler-icon

    .collapse.navbar-collapse#navbarSupportedContent
      ul.navbar-nav.mr-auto
        nuxt-link.nav-item(v-for="v,k of places" :to="k" tag="li" :key="k" exact-active-class="active")
          a.nav-link {{k}}
  beer-list(:getBeers="getBeers")
  footer.text-center
    a(href="https://github.com/brewingcode/yardhouse") github.com
</template>

<script lang="coffee">
import yardhouse from '~/lib/yardhouse.coffee'
import pinebox from '~/lib/pinebox.coffee'

places = {
  yardhouse
  pinebox
}

export default
  data: ->
    places: places
    place: @$route.params.place
  computed:
    getBeers: ->
      places[@$route.params.place]
  validate: ({params}) ->
    places[params.place]
  head: ->
    title: 'Beer: ' + @$route.params.place
</script>
