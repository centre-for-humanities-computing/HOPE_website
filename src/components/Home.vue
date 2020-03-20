<template>
  <div class="home">
    <vHeading
      title="HOPE - How Democracies Cope with COVID19"
      subtitle="A Data-Driven Approach"
    ></vHeading>
    <div class="content">
      <vRepoFile filePath="home.md"></vRepoFile>
      <hr>
      <vFeed></vFeed>
    </div>
  </div>
</template>

<script>
  import vFeed from './vFeed'
  export default {
    name: 'Home',
    components: {
      vFeed
    }
  }
</script>
<style scoped>

  .content>*:not(:last-child) {
    margin-bottom: 2em;
  }
</style>
