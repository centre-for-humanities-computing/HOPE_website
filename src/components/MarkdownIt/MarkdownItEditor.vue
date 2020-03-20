<template>
  <textarea
    class="mdInput"
    v-model="md"
  ></textarea>
</template>

<script>
  export default {
    name: "MarkdownItEditor",
    props: {
      md: {
        type: String,
        required: true
      }
    }
  }
</script>

<style scoped>
.mdInput {
  padding: .5em
}
</style>
