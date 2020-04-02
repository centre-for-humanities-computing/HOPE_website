<template>
  <div id="app">
    <div class="page" id="page">
      <vNavigation class="page__header"/>
      <div class="page__content theme--normal" id="content">
        <box />
      </div>
      <vFooter/>
    </div>
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
      vFooter,
    },
    mounted() {
      vm = this
      this.$nextTick(function () {
        window.addEventListener('resize', vm.trackWindowSize)
        vm.trackWindowSize()
      })
    },
    methods: {
      trackWindowSize() {
        this.windowWidth = window.innerWidth
        this.windowHeight = window.innerHeight
      },
    }
  }
</script>

<style>
  body {
    background-color: #4d5760;
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
  .page__content__block,
  .page__content {
    background-color: white!important;
  }
</style>
