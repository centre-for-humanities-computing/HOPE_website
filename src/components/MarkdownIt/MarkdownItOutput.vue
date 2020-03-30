<template>
  <div class="generic mitOutput">
    <vGeneric :template="template"></vGeneric>
  </div>
</template>

<script>
  import vGeneric from '../vGeneric'
  import mit from './markdownIt'
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
        let pmd = this.md
        pmd = this.replaceImagesWithImageComponent(pmd)
        pmd = this.convertImageAdjacentParagraphToImageTitle(pmd)
        return pmd
      }
    },
    created() {
      let html = mit.render(this.processedMarkdown)
      this.template = `<div class="md">${html}</div>`
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
      },
      convertImageAdjacentParagraphToImageTitle(md) {
        const rxVImageTag = '(<vImage src="[^"]+" alt="[^"]+" :isOdd="(?:true|false)"/>)'
        const rxText = '(.+)'
        const rxAdjacentParagraph = new RegExp(`${rxVImageTag}\\s?${rxText}\\s{2,}`, 'g')
        let processed = md
        let match
        do {
          match = rxAdjacentParagraph.exec(md)
          if (match) {
            const substitute = `
<div>
  ${match[1]}
  <div class="subtitle">${match[2]}</div>
</div>
`
            processed = processed.replace(match[0], substitute)
          }
        } while (match)
        return processed
      }
    }
  }
</script>

<style>

</style>
