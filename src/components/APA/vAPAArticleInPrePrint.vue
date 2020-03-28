<template>
  <markdown-it-output :md="citation"></markdown-it-output>
</template>

<script>
  export default {
    name: "vAPAArticleInPrePrint",
    props: {
      reference: {
        type: Object,
        required: true
      }
    },
    data() {
      return {
        notation: '$authors ($publicationYear, $publicationMonth $publicationDay). _$articleTitle_. $contextName. $doiUrl'
      }
    },
    computed: {
      citation() {
        const authors = this.reference.authors.join(', ')
        const month = this.$moment.months(this.reference.publicationMonth - 1)
        const title = this.removeTrailingPeriod(this.reference.articleTitle)
        const contextName = this.removeTrailingPeriod(this.reference.contextName)

        let citation = this.notation
          .replace(/\$authors/g, authors)
          .replace(/\$publicationYear/g, this.reference.publicationYear)
          .replace(/\$publicationMonth/g, month)
          .replace(/\$publicationDay/g, this.reference.publicationDay)
          .replace(/\$articleTitle/g, title)
          .replace(/\$contextName/g, contextName)
          .replace(/\$doiUrl/g, this.reference.doiUrl)

        return citation
      }
    },
    methods: {
      removeTrailingPeriod(entry) {
        const hasTrailingPeriod = entry.lastIndexOf('.') === entry.length - 1
        return hasTrailingPeriod ? entry.substr(0, entry.length - 1) : entry
      },
    }
  }
</script>

<style scoped>

</style>
