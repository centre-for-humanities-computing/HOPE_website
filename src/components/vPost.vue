<template>
  <div class="post">
    <vRepoFile :filePath="filePath"></vRepoFile>
  </div>
</template>

<script>
  import repoFileMixin from "../mixins/repoFileMixin"
  export default {
    name: "vPost",
    mixins: [
      repoFileMixin
    ],
    props: {
      filePath: {
        type: String,
        required: true
      }
    },
  }
</script>

<style scoped>

</style>
