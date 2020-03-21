<template>
  <div id=navigation class="flex">
    <div
      class="item light"
      :class="{dark: index === activeIndex}"
      v-for="(route, index) in menuRoutes"
      :key="index"
    >
      <div
        class="link flex"
        @click="push(route.path)"
      >
        {{route.title}}
      </div>
    </div>
  </div>
</template>

<script>
import {routes} from '../router'

export default {
  name: 'Navigation',
  data() {
    return {
      routes,
      menuRoutes: routes.filter(r => r.inMenu),
      drawer: false,
      activeIndex: 0
    }
  },
  methods: {
    push(url) {
      this.drawer = false
      this.$router.push(url)
      this.activeIndex = this.menuRoutes.findIndex(r => r.path === url)
    },
  }
}
</script>

<style scoped>
  #navigation {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .item {
    padding: .2em 0;
    width: 20em;
    max-width: 200px;
    text-align: center;
  }
</style>
