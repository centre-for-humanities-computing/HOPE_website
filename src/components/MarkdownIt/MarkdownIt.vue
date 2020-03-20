<template>
  <div class="mdEditor">
    <markdown-it-editor :md="md"></markdown-it-editor>
    <markdown-it-output :md="md"></markdown-it-output>
  </div>
</template>

<script>
  import MarkdownItEditor from './MarkdownItEditor'
  import MarkdownItOutput from './MarkdownItOutput'
  export default {
    name: "MarkdownIt",
    components: {
      MarkdownItEditor,
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
