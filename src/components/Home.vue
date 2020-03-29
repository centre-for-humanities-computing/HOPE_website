<template>
  <div class="home">
    <vHeading
      title="HOPE - How Democracies Cope with COVID19"
      subtitle="A Data-Driven Approach"
    ></vHeading>
    <div class="content">
      <vRepoFile
        class="card body"
        filePath="HOPE/one.md"></vRepoFile>
      <vRepoFile
        class="card body"
        filePath="HOPE/two.md"></vRepoFile>
      <vRepoFile
        class="card body"
        filePath="HOPE/three.md"></vRepoFile>
      <vRepoFile
        class="card body"
        filePath="HOPE/four.md"></vRepoFile>
    </div>
  </div>

</template>

<script>
  export default {
    name: 'Home',
  }
</script>
<style scoped>
  .content {
    display: grid;
    grid-template-columns: auto auto;
  }
  @media only screen and (max-width: 720px) {
    .content {
      grid-template-columns: auto;
    }
  }
</style>
