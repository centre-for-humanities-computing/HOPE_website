<template>
  <div class="about">
    <vHeading
      title="About Us"
    ></vHeading>
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
  .about {
    width: 100%;
  }
</style>
