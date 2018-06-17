<template lang="pug">
  div
    app-logo
    h1.title yardhouse
    h2.subtitle.
      A better listing of Yard House beers
    .links
      a(href="https://nuxtjs.org/" target="_blank" class="button--green") Documentation
      a(href="https://github.com/nuxt/nuxt.js" target="_blank" class="button--grey") GitHub
    div(style="width:100%")
      pre(v-for="beer in beers") {{JSON.stringify(beer, null, '  ')}}
</template>

<script lang="coffee">
import AppLogo from '~/components/AppLogo.vue'
import axios from 'axios'
import cheerio from 'cheerio'

export default
  components: { AppLogo }
  asyncData: ->
    axios.get 'https://www.brewingcode.net/yardhouse.php?'
      .then (res) ->
        $ = cheerio.load(res.data)
        beers: $('.menu_item').map ->
          title: $('.beerlink', this).text()
          tags: $('.beer_icons img', this).map(-> $(this).attr('alt')).get()
          style: $('.beer-style', this).text()
          abv: $('.beer-abv', this).text()
          origin: $('.beer-origin', this).text()
        .get()
        .filter (b) -> b.title

      .catch (err) ->
        console.error 'error getting live view of beer list'
        beers: []
</script>

<style>
.container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family: "Quicksand", "Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; /* 1 */
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
