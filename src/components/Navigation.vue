<template>
  <div id=navigation class="flex shadow">
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
    width: 100vm;
  }
  .item {
    padding: .2em 0;
    width: 100%;
    text-align: center;
  }
</style>
