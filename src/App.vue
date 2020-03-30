<template>
  <div
    id="app"
    :style="{fontSize: fontSize + '%'}"
  >
    <div class="page">
      <vNavigation class="page__header"/>
      <div
        class="page__content__block page__content__block--no-padding"
      >
        <box />
      </div>

    </div>
    <vFooter />
  </div>
</template>

<script>
  import Box from './components/Box'
  import vFooter from './components/vFooter'
  let vm
  export default {
    name: 'App',
    components: {
      Box,
      vFooter
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
/*  body {
    display: flex;
    flex-direction: column;
    align-items: center;
    font-family: 'AU Passata', sans-serif;
    background-color: #4d5760;
    background-position: top left;
    background-repeat: no-repeat;
    background-size: cover;
    background-blend-mode: color-dodge;
    background-image: url('assets/background.jpg');
    line-height: 2rem;
    font-weight: 300;
    margin: 0;
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
  h1, h2, h3, h4, h5, h6 {
    font-weight: 500;
  }
  .heading {
    font-size: larger;
  }
  p {
    display: block;
    margin-block-start: 1rem;
    margin-block-end: 1rem;
    margin-inline-start: 0;
    margin-inline-end: 0;
  }
  img {
    border-radius: .2rem
  }
  ul {
    list-style-type: circle;
  }
  .body {
    padding: 0 1.5rem;
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
    margin-bottom: 3rem;
    top: 20px;
    padding: 1.5rem 3rem;
    border-radius: .2rem;
    background-color: rgba(255, 255, 255, 0.97);
    color: #282828;
    box-shadow: 0 0 10px 0 rgba(40,40,40,0.3);
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
  .md {
    display: inline-block;
  }
  .md p {
    text-align: justify;
  }
  .md hr {
    clear: both;
    margin: 2rem;
  }
  .md pre.hljs code {
    box-shadow: none!important;
    border-radius: 0!important;
    background-color: transparent!important;
    color: inherit!important;
    font-style: inherit!important;
    font-weight: inherit!important;
  }
  .md blockquote {
    margin-left: 1rem;
  }
  .md img {
    max-width: 100%;
  }
  @media only screen and (max-width: 720px) {
    .body {
      padding: 0;
    }
    .page {
      width: 100vm;
    }
    .card {
      margin: 0.2rem;
    }
    .body {
      padding: .2rem;
    }
    .box .side {
      width: 100vm;
    }
    .side > * {
      padding: 1.3rem 0.5rem;
    }
  }
 */
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
