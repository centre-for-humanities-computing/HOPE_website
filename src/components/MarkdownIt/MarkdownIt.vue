<template>
  <div class="mdEditor">
    <markdown-it-output :md="md"></markdown-it-output>
  </div>
</template>

<script>
  import MarkdownItOutput from './MarkdownItOutput'
  export default {
    name: "MarkdownIt",
    components: {
      MarkdownItOutput
    },
    props: {
      md: {
        type: String,
        required: true
      }
    },
  }
</script>

<style scoped>
  .mdEditor {
    display: grid;
    grid-template-columns: 50% auto;
  }
</style>
