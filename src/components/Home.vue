<template>
  <div class="home">
    <h1>
      <strong class="u-no-wrap">
        HOPE - How Democracies Cope with COVID19
      </strong>
      A Data-Driven Approach
    </h1>
    <div
      id="homeContent"
      class="content">
      <vRepoFile
        class="box theme--background-secondary"
        filePath="HOPE/one.md"></vRepoFile>
      <vRepoFile
        class="box theme--background-secondary"
        filePath="HOPE/two.md"></vRepoFile>
      <vRepoFile
        class="box theme--background-secondary"
        filePath="HOPE/three.md"
        :hideTillLoaded="true"
      ></vRepoFile>
      <vRepoFile
        class="box theme--background-secondary"
        filePath="HOPE/four.md"
        :hideTillLoaded="true"
      ></vRepoFile>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Home',
  }
</script>
<style scoped>
  .home {
    height: 100%;
  }
  .content {
    display: grid;
    grid-template-columns: auto auto;
  }
  .content > * {
    margin: 4px;
  }
  @media only screen and (max-width: 860px) {
    .content {
      grid-template-columns: auto;
    }
  }
</style>
