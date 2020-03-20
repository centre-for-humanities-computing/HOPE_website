<template>
  <div class="home">
    <div class="heading">
      <h1>HOPE - How Democracies Cope with Covid19</h1>
      <p>A Data-Driven Approach</p>
    </div>
    <md :source="md"></md>

  </div>
</template>

<script>
  import homeMD from '../../content/home.md'
  export default {
    name: 'Home',
    data() {
      return {
        md: homeMD.source
      }
    },
  }
</script>
<style scoped>

</style>
