<template>
  <div class="nav nav--site-nav theme--dark">
    <h1 class="nav__home">
      <a class="nav__home__title" href="#">
        HOPE Project
      </a>
    </h1>
    <div class="nav__site">
      <div class="nav__items">
        <a
          class="nav__item"
          :class="{'nav__item--active': index === activeIndex}"
          v-for="(route, index) in menuRoutes"
          :key="index"
          @click="push(route.path)"
        >
          {{route.title}}
        </a>
      </div>
      <button class="nav__toggle">Menu</button>
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

</style>
