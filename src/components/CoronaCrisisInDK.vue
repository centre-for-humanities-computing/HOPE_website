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
          @click="language = 'en'"
          class="button button--text">
          Show this page in english
        </button>
      </div>
      <div v-show="language !== 'da'">
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_1_da.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_2_da.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_3_da.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_4_da.md" />
      </div>
      <div v-show="language !== 'en'">
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_1_en.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_2_en.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_3_en.md" />
        <vRepoFile filePath="CoronaCrisisInDK/coronaCrisis_4_en.md" />
      </div>
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
  mounted() {
    this.language = 'en'
  }
}
</script>

<style scoped>
  .button-container {
    float: right;
  }
  .home {
    height: 100%;
  }
  .content {
    display: grid;
    grid-template-columns: auto auto;
  }
  .content > * {
    margin: 4px;
  }
  @media only screen and (max-width: 860px) {
    .content {
      grid-template-columns: auto;
    }
  }
</style>
