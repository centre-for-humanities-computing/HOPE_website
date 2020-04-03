<template>
  <div class="dashboard">
    <iframe
      src="https://hope-project.dk/dashboard"
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
          loaded: false
        }
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
