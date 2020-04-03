<template>
  <div class="dashboard">
    <iframe
      :src="src"
      frameborder="0"
      scrolling="no"
      @load="resizeIframe"
      v-show="iframe.loaded"
    ></iframe>
  </div>
</template>

<script>
  export default {
    name: "vDashboard",
    data() {
      return {
        iframe: {
          src: '',
          loaded: false
        }
      }
    },
    computed: {
      src() {
        return 'https://www.google.com/search?q=%http://hope-project.dk/dashboard&btnI=Im+Feeling+Lucky'
      }
    },
    methods: {
      resizeIframe(event) {
        // only works in production environment (no CORS)
        const iframe = event.target
        iframe.style.height = iframe.contentWindow.document.documentElement.scrollHeight + 'px';
        this.iframe.loaded = true
      }
    }
  }
</script>

<style scoped>
  .dashboard {
    height: 100vh;
    width: 100%;
  }
  iframe {
    height: 100vh;
    width: 100%;
  }
</style>
