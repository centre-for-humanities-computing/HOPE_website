<template>
  <div
    id="app"
    :style="{fontSize: fontSize + '%'}"
  >
    <navigation />
    <div
      class="page"
    >

      <div
        id="pageContent"
        class="gridKids"
      >
        <box />
      </div>

    </div>
  </div>
</template>

<script>
  import Navigation from './components/Navigation'
  import Box from './components/Box'
  let vm
  export default {
    name: 'App',
    components: {
      Navigation,
      Box
    },
    data() {
      return {
        fontSize: 100
      }
    },
    computed: {
      hasStore() {
        return this.$store.state[this.$route.title]
      },
      hasSlides() {
        return this.hasStore && this.$store.state[this.$route.title].slides
      },
      minFontSize() {
        return this.$store.state.minFontSize
      },
      maxFontSize() {
        return this.$store.state.maxFontSize
      }
    },
    mounted() {
      vm = this
      this.$nextTick(function () {
        window.addEventListener('resize', vm.trackWindowSize)
        window.addEventListener('resize', vm.adjustFontSize)
        vm.trackWindowSize()
        vm.adjustFontSize()
      })
    },
    methods: {
      trackWindowSize() {
        this.windowWidth = window.innerWidth
        this.windowHeight = window.innerHeight
      },
      adjustFontSize() {
        const nominalSize = 100
        const thresholdWidth = 1000
        if (window.innerWidth < thresholdWidth) {
          this.fontSize = Math.min(Math.max(this.minFontSize, this.windowWidth / 6), nominalSize)
        } else {
          this.fontSize = Math.min(Math.max(nominalSize, this.windowHeight / 10), this.maxFontSize)
        }
      }
    }
  }
</script>

<style lang="scss">
  body {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
  }
  .card {
    box-shadow: .1em 0 .3em #ddd;
    margin-bottom: 1em;
  }
  .body {
    padding: 1em;
  }
</style>
