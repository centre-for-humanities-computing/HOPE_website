<template>
  <div
    id="app"
    :style="{fontSize: fontSize + '%'}"
  >

    <div
      class="page__content__block page__content__block--no-padding"
    >
      <box />
    </div>

  </div>
</template>

<script>
  import Box from './components/Box'
  let vm
  export default {
    name: 'App',
    components: {
      Box,
    },
    data() {
      return {
        fontSize: 100
      }
    },
    computed: {
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
        const thresholdWidth = 800
        if (window.innerWidth < thresholdWidth) {
          this.fontSize = Math.min(Math.max(this.minFontSize, this.windowWidth / 6), nominalSize)
        } else {
          this.fontSize = Math.min(Math.max(nominalSize, this.windowHeight / 10), this.maxFontSize)
        }
      }
    }
  }
</script>

<style>
  body {
    background-color: #4d5760;
  }
  #app {
    width: 100%;
    max-width: 1400px;
  }
  .shadow {
    box-shadow: 0 0 1em 0 rgba(40,40,40,0.5);
  }
  .card {
    margin: 0.5em;
    background-color: rgba(255, 255, 255, 0.98);
    color: #262626;
    box-shadow: .12em .12em .29em 0 rgba(40,40,50,0.3);
  }

</style>
