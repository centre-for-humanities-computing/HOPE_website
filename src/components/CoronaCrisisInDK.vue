<template>
  <div class="page__content theme--normal">
    <div class="page__content__block">
      <div class="button-container">
        <button
          v-if="language !== 'da'"
          @click="language = 'da'"
          class="button button--text">
          dansk
        </button>
        <button
          v-if="language !== 'en'"
          @click="language = 'en'"
          class="button button--text">
          english
        </button>
      </div>
      <h1><strong>What is the status of the development in the corona situation?</strong></h1>
      <p>Tracking covid-19 symptoms, Danes' behavior, habits and experiences</p>
      <div class="content">
        <div v-show="language !== 'da'">
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_1_da.md"
            :id="getId('coronaCrisis_1_da.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_2_da.md"
            :id="getId('coronaCrisis_2_da.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_3_da.md"
            :id="getId('coronaCrisis_3_da.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_4_da.md"
            :id="getId('coronaCrisis_4_da.md')"
            class="box theme--background-secondary"
          />
        </div>

        <div v-show="language !== 'en'">
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_1_en.md"
            :id="getId('coronaCrisis_1_en.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_2_en.md"
            :id="getId('coronaCrisis_2_en.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_3_en.md"
            :id="getId('coronaCrisis_3_en.md')"
            class="box theme--background-secondary"
          />
          <vRepoFile
            filePath="CoronaCrisisInDK/coronaCrisis_4_en.md"
            :id="getId('coronaCrisis_4_en.md')"
            class="box theme--background-secondary"
          />
        </div>
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
  },
  methods: {
    getId(filePath) {
      return filePath.replace(/[^\wæøåÆØÅ-]/gi, '_')
    }
  },
}
</script>

<style scoped>
  .button-container {
    top: 200px;
    right: 2rem;
    position: absolute;
    z-index: 1;
  }
  .home {
    height: 100%;
  }
  .content {
    display: grid;
    grid-template-columns: auto auto;
  }
  .content .box {
    margin: 4px;
  }
  @media only screen and (max-width: 860px) {
    .content {
      grid-template-columns: auto;
    }
  }
</style>
