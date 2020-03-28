<template>
  <div class="people">
    <div class="list">
      <div
        v-for="(entry, index) in file"
        :key="index"
        class="item">
        <vPerson :person="entry"></vPerson>
      </div>
    </div>
  </div>
</template>

<script>
import vPerson from './vPerson'
import repoFileMixin from "../mixins/repoFileMixin"
export default {
  name: 'vPeople',
  components: {
    vPerson
  },
  mixins: [
    repoFileMixin
  ],
  props: {
    filePath: {
      type: String,
      default: 'people.json'
    }
  },
}
</script>

<style scoped>
  .people {
    text-align: center;
  }
  .list {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
  }
  .item {
    display: flex;
    align-items: stretch;
    justify-content: stretch;
  }
</style>
