<template>
  <div class="publications">
        <div class="list">
          <div
            v-for="(entry, index) in file"
            :key="index"
            class="item"
          >
            <vAPACitation :citation="entry"></vAPACitation>
          </div>
    </div>
  </div>
</template>

<script>
import vAPACitation from './APA/vAPACitation'
import repoFileMixin from "../mixins/repoFileMixin"
export default {
  name: 'vPublications',
  components: {
    vAPACitation
  },
  mixins: [
    repoFileMixin
  ],
  props: {
    filePath: {
      type: String,
      default: 'publications/publications.json'
    }
  },
}
</script>

<style scoped>
  .publications {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: left;
    min-width: 100%;
    height: 100%
  }
  .list {
    max-width: 38rem;
  }
</style>
