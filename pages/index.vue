<template lang="pug">
beer-list(:getBeers="getBeers")
</template>

<script lang="coffee">
import BeerList from '~/components/BeerList'
import Yardhouse from '~/lib/yardhouse.coffee'

export default
  components: { BeerList }

  data: ->
    getBeers: Yardhouse
</script>
