<template>
  <markdown-it-output v-if="file" :md="file"></markdown-it-output>
  <vSpinner v-else-if="!hideTillLoaded"></vSpinner>
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
    ],
    props: {
      hideTillLoaded: {
        type: Boolean,
        default: false
      }
    }
  }
</script>

<style scoped>

</style>
