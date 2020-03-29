<template>
  <div class="navigation">
    <div class="logo"></div>
    <div class="links">
      <div
        class="item light"
        :class="{dark: index === activeIndex}"
        v-for="(route, index) in menuRoutes"
        :key="index"
      >
        <div
          class="link"
          @click="push(route.path)"
        >
          <span>{{route.title}}</span>
        </div>
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
  .navigation {
    display: flex;
    width: 100%;
    justify-content: space-evenly;
    align-items: center;
    background: rgb(19,36,86);
    background: linear-gradient(180deg, rgba(19,36,86,1) 0%, rgba(0,7,30,1) 100%);
  }
  .logo {
    background-image: url(../assets/bss_logo.png);
    background-size: cover;
    background-repeat: no-repeat;
    min-height: 144px;
    min-width: 144px;
  }
  .links {
    display: flex;
    width: 100%;
    justify-content: space-evenly;
    align-items: center;
  }
  .item {
    padding: .2em 0;
    width: 24%;
    min-width: 6em;
    max-width: 200px;
    text-align: center;
  }
  @media only screen and (max-width: 580px) {
    .links {
      display: grid;
      grid-template-columns: auto auto;
    }
    .item {
      margin: 4px;
    }
  }

</style>
