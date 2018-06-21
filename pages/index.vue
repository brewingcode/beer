<template lang="pug">
beer-list(:getBeers="getBeers")
</template>

<script lang="coffee">
import Yardhouse from '~/lib/yardhouse.coffee'

export default
  data: ->
    getBeers: Yardhouse
</script>
