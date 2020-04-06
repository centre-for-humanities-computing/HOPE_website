<template>
  <div class="news">
    <div
      v-if="file"
      class="feed">
      <vPost
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
    name: "vNews",
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
            .split('\n')
            .map(n => `newsfeed/${n.trim()}`)
        }
        return articleNames
      }
    }
  }
</script>

<style scoped>
  .news {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .feed .post {
    max-width: 38rem;
    margin-block-end: 1em;
  }
</style>
