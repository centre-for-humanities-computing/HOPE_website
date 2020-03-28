<template>
  <div class="generic mitOutput">
    <vGeneric :template="template"></vGeneric>
  </div>
</template>

<script>
  import vGeneric from '../vGeneric'
  import mit from './markdownIt'
  import { SET_SCENE_HEIGHT_IS_DIRTY } from "../../modules/box/types"
  export default {
    name: "MarkdownItOutput",
    components: {
      vGeneric
    },
    props: {
      md: {
        type: String,
        required: true
      }
    },
    data() {
      return {
        template: '<span>empty</span>'
      }
    },
    computed: {
      processedMarkdown() {
        return this.replaceImagesWithImageComponent(this.md)
      }
    },
    created() {
      let html = mit.render(this.processedMarkdown)

      this.template = `<div class="md">${this.replaceImagesWithImageComponent(html)}</div>`
      this.$store.commit('box/' + SET_SCENE_HEIGHT_IS_DIRTY, true)
    },
    methods: {
      replaceImagesWithImageComponent(md) {
        const rxImageMd = /<img (?:src="(http[^"]+)" alt="([^"]+)")>/g
        let processed = md
        let match
        let index = 0
        do {
          match = rxImageMd.exec(md)
          if (match) {
            const component = `<vImage src="${match[1]}" alt="${match[2]}" :isOdd="${!!(index % 2)}"/>`
            processed = processed.replace(match[0], component)
          }
          index++
        } while (match)
        return processed
      }
    }
  }
</script>

<style>

</style>
