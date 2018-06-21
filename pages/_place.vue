<template lang="pug">
div
  template(v-for='v,k in places')
    nuxt-link(:to='k') {{k}}
  beer-list(:getBeers="getBeers")
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
  computed:
    getBeers: ->
      places[@$route.params.place]
  validate: ({params}) ->
    places[params.place]
  head: ->
    title: 'Beer: ' + @$route.params.place
</script>
