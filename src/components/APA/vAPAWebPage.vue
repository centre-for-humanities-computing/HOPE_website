<template>
  <markdown-it-output :md="citation"></markdown-it-output>
</template>

<script>
  export default {
    name: "vAPAWebPage",
    props: {
      reference: {
        type: Object,
        required: true
      }
    },
    data() {
      return {
        notation: '$authors ($publicationYear, $publicationMonth $publicationDay). $magazineTitle. _$titleOfPage_. Retrieved $accessMonth $accessDay, $accessYear, from $url'
      }
    },
    computed: {
      citation() {
        const authors = this.reference.authors.join(', ')
        const publicationMonth = this.$moment.months(this.reference.publicationMonth - 1)
        const accessMonth = this.$moment.months(this.reference.accessMonth - 1)
        const titleOfPage = this.removeTrailingPeriod(this.reference.titleOfPage)
        const magazineTitle = this.removeTrailingPeriod(this.reference.magazineTitle)

        let citation = this.notation
          .replace(/\$authors/g, authors)
          .replace(/\$publicationYear/g, this.reference.publicationYear)
          .replace(/\$publicationMonth/g, publicationMonth)
          .replace(/\$publicationDay/g, this.reference.publicationDay)
          .replace(/\$magazineTitle/g, magazineTitle)
          .replace(/\$titleOfPage/g, titleOfPage)
          .replace(/\$accessMonth/g, accessMonth)
          .replace(/\$accessDay/g, this.reference.accessDay)
          .replace(/\$accessYear/g, this.reference.accessYear)
          .replace(/\$url/g, this.reference.url)

        return citation
      },
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
