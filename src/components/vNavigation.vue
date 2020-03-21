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
  name: 'vNavigation',
  data() {
    return {
      routes,
      menuRoutes: routes.filter(r => r.inMenu),
      drawer: false,
    }
  },
  computed: {
    activeRoute() {
      return this.$store.state.activeRoute
    },
    activeIndex() {
      return this.menuRoutes.findIndex(r => r.path === this.activeRoute)
    }
  },
  methods: {
    push(url) {
      if (url !== this.activeRoute) {
        this.$router.push(url)
        this.$store.commit('SET_ACTIVE_ROUTE', url)
      }
    },
  }
}
</script>

<style scoped>
  #navigation {
    display: flex;
    max-width: 90%;
    justify-content: space-evenly;
    align-items: center;
    margin: -30px 0 2em 0;
  }
  .item {
    padding: .2em 0;
    width: 22%;
    min-width: 6em;
    max-width: 200px;
    text-align: center;
  }
</style>
