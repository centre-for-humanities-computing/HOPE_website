<template>
  <div class="feed">
    <vHeading
      title="News"
      :level="1"></vHeading>
    <div
      v-if="file"
      class="list">
      <vPost
        class="post"
        v-for="(articleName, index) in articleNames"
        :key="index"
        :filePath="articleName"
      ></vPost>
    </div>
  </div>
</template>

<script>
  import vPost from './vPost'
  import repoFileMixin from "../mixins/repoFileMixin"
  export default {
    name: "Feed",
    components: {
      vPost
    },
    mixins: [
      repoFileMixin
    ],
    props: {
      filePath: {
        type: String,
        default: 'newsfeed/articleSequence'
      }
    },
    computed: {
      articleNames() {
        let articleNames
        if (this.file) {
          articleNames = this.file
            .trim()
            .split('/n')
            .map(n => `newsfeed/${n.trim()}`)
        }
        return articleNames
      }
    }
  }
</script>

<style scoped>

</style>
