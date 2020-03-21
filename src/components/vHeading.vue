<template>
  <div
    class="heading"
    :class="{center: level === 1}"
  >
    <h1
      class="title"
      v-if="level === 1">
      {{title}}
    </h1>
    <h2
      class="title"
      v-else-if="level === 2">
      {{title}}
    </h2>
    <span
      v-if="subtitle"
      class="subtitle"
    >
      {{subtitle}}
    </span>
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
    line-height: 2em;
  }
  .subtitle {
    position: relative;
    top: -1.3em;
  }
</style>
