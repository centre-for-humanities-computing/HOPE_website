<template>
  <footer class="footer">
    <div class="page__footer">
      <object class="page__footer__logo" role="img" type="image/svg+xml" aria-label="The logo of Aarhus Universtity" tabindex="-1">
        <p>The logo of Aarhus University.</p>
      </object>
      <object class="page__footer__seal" role="img" type="image/svg+xml" aria-label="The seal of Aarhus Universtity" tabindex="-1">
        <p>The seal of Aarhus University. The seal depicts an anchor surrounded by two dolphins. The university motto and Latin name are written on the outline: Solidum petit in profundis - Universitas Arhusiensis.</p>
      </object>
    </div>
  </footer>
</template>

<script>
  export default {
    name: "vFooter"
  }
</script>

<style scoped>
  footer {
    background-color: var(--color-background);
  }
  .page__footer {
    grid-template-areas: 'logo seal'!important;
  }
</style>
