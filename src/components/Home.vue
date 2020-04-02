<template>
  <div class="home">
    <h1>
        HOPE - How Democracies Cope with COVID19
      <strong class="u-no-wrap">
        A Data-Driven Approach
      </strong>
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
    width: 100%;
  }
  .content {
    display: grid;
    grid-template-columns: auto auto;
  }
  .content > * {
    margin: 4px;
  }
  @media only screen and (max-width: 720px) {
    .content {
      grid-template-columns: auto;
    }
  }
</style>
