<template>
    <div class="about">
      <vRepoFile filePath="aboutUs/theProject.md"></vRepoFile>
      <vPeople filePath="aboutUs/people.json"></vPeople>
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
