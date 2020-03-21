<template>
  <markdown-it-output v-if="file" :md="file"></markdown-it-output>
  <vSpinner v-else></vSpinner>
</template>

<script>
  import vSpinner from './vSpinner'
  import repoFileMixin from "../mixins/repoFileMixin"
  export default {
    name: "vRepoFile",
    components: {
      vSpinner
    },
    mixins: [
      repoFileMixin
    ]
  }
</script>

<style scoped>

</style>
