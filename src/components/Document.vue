<template>
    <div class="document">
      <div>
        <vRepoFile :filePath="filePath"></vRepoFile>
      </div>
    </div>
</template>

<script>
  export default {
    name: "Document",
    props: {
      directory: {
        type: String,
        required: true
      },
      filename: {
        type: String,
        required: true
      },
    },
    computed: {
      filePath() {
        return `${this.directory}/${this.filename}`
      }
    }
  }
</script>

<style scoped>
  .about {
    height: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
  }
</style>
