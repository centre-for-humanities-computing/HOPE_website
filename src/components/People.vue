<template>
  <div class="people">
    <vHeading
      title="People"
    ></vHeading>
    <div class="list">
      <vPerson
        v-for="(entry, index) in file"
        :key="index"
        :person="entry"
      ></vPerson>
    </div>
  </div>
</template>

<script>
import vPerson from './vPerson'
import repoFileMixin from "../mixins/repoFileMixin"
export default {
  name: 'People',
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
    align-items: center;
    justify-content: space-around;
  }
</style>
