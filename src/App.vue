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
        minFontSize: 100,
        maxFontSize: 200,
        fontSize: 120
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
        const nominalSize = 120
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
  @import url('https://fonts.googleapis.com/css?family=Fira+Sans&display=swap');
  body {
    display: flex;
    flex-direction: column;
    padding: 0 2vm 2em 0;
    align-items: center;
    justify-content: center;
    font-family: 'Fira Sans', sans-serif;
    background-color: #444d56;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    background-blend-mode: color-dodge;
    background-image: url('assets/background.jpg');
  }
  #app {
    width: 100%;
    max-width: 1400px;
  }
  .body {
    padding: 1.5em;
  }
  .box .side {
    width: 96vm;
    max-width: 1400px;
  }
  .side {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .side > * {
    position: fixed;
    margin-bottom: 3em;
    top: 20px;
    padding: 1.5em 3em;
    border-radius: .2em;
    /* light */
    background-color: rgba(255, 255, 255, 0.98);
    color: #262626;
    /* shadow */
    box-shadow: 0 0 10px 0 rgba(40,40,40,0.3);
  }

  .flex {
    display: flex;
    flex-direction: row;
    align-items: stretch;
    justify-content: center;
  }
  .center {
    text-align: center;
  }

  .light {
    background-color: rgba(255, 255, 255, 0.98);
    color: #262626;
  }
  .dark {
    background-color: rgba(0,0,0,0.5);
    color: white;
  }
  .shadow {
    box-shadow: 0 0 1em 0 rgba(40,40,40,0.5);
  }

  .card {
    margin-bottom: 1em;
    /* light */
    background-color: rgba(255, 255, 255, 0.98);
    color: #262626;
    /* shadow */
    box-shadow: .1em .1em .5em 0 rgba(40,40,40,0.3);
  }

</style>
