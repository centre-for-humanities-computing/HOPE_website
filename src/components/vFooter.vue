<template>
  <div class="footer">
    <div class="logo"></div>
  </div>
</template>

<script>
  export default {
    name: "vFooter"
  }
</script>

<style scoped>
  .footer {
    position: relative;
    bottom: 0;
    height: 147px;
    width: 100%;
    background: rgb(19,36,86);
    background: linear-gradient(180deg, rgba(19,36,86,1) 0%, rgba(0,7,30,1) 100%);
  }
  .logo {
    background-image: url(../assets/bss_logo.png);
    background-repeat: no-repeat;
    height: 100%;
  }

</style>
