<template>
  <div class="publications">
    <div class="page__content theme--normal">
      <div class="page__content__block">
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
    text-align: left;
    min-width: 100%;
  }
</style>
