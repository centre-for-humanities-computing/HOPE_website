<template>
  <div class="APACitation citation">
    <component
      class="icon"
      :is="contextIcon"
      :title="citation.context"
      fillColor="#FF0000"
    ></component>
    <component
      v-if="citationContextComponentName"
      :is="citationContextComponentName"
      :reference="citation"
    ></component>
    <div
      v-else
      class="error"
    >
      unsupported citation context name: "{{citation.context}}"
    </div>
  </div>
</template>

<script>
  import vAPAArticleInPrePrint from "./vAPAArticleInPrePrint"
  import vAPAWebPage from "./vAPAWebPage"
  import {default as HelpIcon} from 'vue-material-design-icons/Help'
  import {default as WebIcon} from 'vue-material-design-icons/Web.vue'
  import {default as CloudPrintIcon} from 'vue-material-design-icons/CloudPrint.vue'

  export default {
    name: "vAPACitation",
    components: {
      vAPAArticleInPrePrint,
      vAPAWebPage,
      HelpIcon,
      WebIcon,
      CloudPrintIcon,
    },
    props: {
      citation: {
        type: Object,
        required: true
      }
    },
    computed: {
      citationContextComponentName() {
        let capitalizedContextName = this.citation.context[0].toUpperCase() + this.citation.context.substr(1)
        capitalizedContextName = `vAPA${capitalizedContextName}`
        const componentIsKnown = this.$options.components[capitalizedContextName]
        return componentIsKnown ? capitalizedContextName : false
      },
      contextIcon() {
        const cName = this.citationContextComponentName
        let icon
        if (!cName) {
          icon = 'Help'
        } else if (cName === 'vAPAWebPage') {
          icon = 'Web'
        } else if (cName === 'vAPAArticleInPrePrint') {
          icon = 'CloudPrint'
        }
        return icon + 'Icon'
      }
    }
  }
</script>

<style scoped>
  .citation {
    display: grid;
    grid-template-columns: 8em auto;
  }
  .icon {
    font-size: 3em;
  }
</style>
