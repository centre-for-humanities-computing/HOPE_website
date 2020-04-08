<template>
    <div class="about">
      <div>
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
  .about {
    height: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
  }
</style>
