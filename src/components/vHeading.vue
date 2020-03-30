<template>
  <div
    class="heading"
    :class="{center: level === 1}"
  >
    <h1
      class="title"
      v-if="level === 1">
      {{title}}{{subtitle || ''}}
    </h1>
  </div>
</template>

<script>
  export default {
    name: "vHeading",
    props: {
      title: {
        type: String,
        required: true
      },
      subtitle: {
        type: String
      },
      level: {
        type: Number,
        default: 1
      }
    }
  }
</script>

<style scoped>
  .heading {
    margin-bottom: 2em;
  }
  .heading h1,
  .heading h2
  {
    margin-bottom: 0.1em;
    line-height: 1.4em;
  }
  .subtitle {
    position: relative;
  }
</style>
