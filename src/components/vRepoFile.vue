<template>
  <div
    v-if="file || !hideTillLoaded"
    :id="id"
  >
    <markdown-it-output v-if="file" :md="file"></markdown-it-output>
    <vSpinner v-else-if="!hideTillLoaded"></vSpinner>
  </div>
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
    },
    computed: {
      id () {
        return this.fileName.replace(/[^\wæøåÆØÅ-]/gi, '_')
      }
    }
  }
</script>

<style scoped>

</style>
