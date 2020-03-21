<template>
  <div
    id="app"
    :style="{fontSize: fontSize + '%'}"
  >
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
  import Box from './components/Box'
  let vm
  export default {
    name: 'App',
    components: {
      Box
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
  @import url('https://fonts.googleapis.com/css?family=Roboto&display=swap');
  body {
    display: flex;
    flex-direction: column;
    padding: 0 2vm 2em 0;
    align-items: center;
    justify-content: center;
    font-family: 'Roboto', sans-serif;
    font-size: 1rem;
    background-color: #444d56;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    background-blend-mode: color-dodge;
    background-image: url('assets/background.jpg');
    line-height: 2em;
    font-weight: 300;
  }
  * {
    box-sizing: border-box;
  }
  #app {
    width: 100%;
    max-width: 1400px;
  }
  .page {
    width: 96vm;
  }
  #navigation {
    width: 100%;
  }
  h1, h2, h3, h4, h5, h6 {
    font-weight: 500;
  }
  p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
  }
  img {
    border-radius: .2em
  }
  ul {
    list-style-type: circle;
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
    background-color: rgba(255, 255, 255, 0.97);
    color: #282828;
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
    background-color: rgba(255, 255, 255, 0.97);
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
