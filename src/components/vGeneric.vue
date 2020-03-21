<script>
  // https://jsfiddle.net/Linusborg/1zdzu7k1/
  import Vue from 'vue'
  import vSpinner from './vSpinner'
  import vImage from './vImage'

  export default {
    name: "vGeneric",
    components: {
      vSpinner,
      vImage
    },
    props: ['template'],
    data() {
      return {
        rendered: null,
      };
    },
    watch: {
      template:{
        immediate: true,
        handler() {

          const compiled = Vue.compile(this.template)

          this.rendered = compiled.render
          this.$options.staticRenderFns = compiled.staticRenderFns

        }
      }
    },
    render(h) {
      if (!this.rendered) {
        return h('vSpinner');
      } else {
        return this.rendered()
      }
    },
  }
</script>

<style scoped>

</style>
