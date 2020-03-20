<template>
  <div class="contact">
    <vHeading
      title="Contact"
    ></vHeading>
    <vPerson
      v-if=person
      :person="person"></vPerson>
  </div>
</template>

<script>
  import vPerson from './vPerson'
  import repoFileMixin from "../mixins/repoFileMixin"
  export default {
    name: 'Contact',
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
    computed: {
      person: {
        get() {
          let person
          if (this.file) {
            person = this.file.find(p => p.role === 'PI')
          }
          return person
        }
      }
    }
  }
</script>

<style scoped>
</style>
