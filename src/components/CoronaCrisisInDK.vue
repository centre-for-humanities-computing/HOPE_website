<template>
  <div class="page__content theme--normal">
    <div class="page__content__block">
      <div class="button-container">
        <button
          v-if="language !== 'da'"
          @click="language = 'da'"
          class="button button--text">
          Vis siden på dansk
        </button>
        <button
          v-if="language !== 'en'"
          @click="language = 'en'"
          class="button button--text">
          Show this page in english
        </button>
      </div>
        <vRepoFile
          v-show="language === 'da'"
          filePath="coronaCrisis_da.md" />
        <vRepoFile
          v-show="language === 'en'"
          filePath="coronaCrisis_en.md" />
    </div>
  </div>
</template>

<script>
  import * as actions from '../modules/types'
export default {
  name: 'CoronaCrisisInDK',
  computed: {
    language: {
      get() {
        return this.$store.state.language
      },
      set(val) {
        this.$store.commit(actions.SET_LANGUAGE, val)
      }
    },
  },
}
</script>

<style scoped>
  .button-container {
    float: right;
  }
</style>
