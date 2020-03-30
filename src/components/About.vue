<template>
  <div class="page__content theme--normal">
    <div class="page__content__block">
      <vRepoFile filePath="aboutUs/theProject.md"></vRepoFile>
      <vPeople filePath="aboutUs/people.json"></vPeople>
    </div>
  </div>
</template>

<script>
  import vPeople from './vPeople'
  export default {
    name: "About",
    components: {
      vPeople
    }
  }
</script>

<style scoped>
</style>
