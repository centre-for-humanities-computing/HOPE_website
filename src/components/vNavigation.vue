<template>
  <div class="navigation">
    <div class="nav nav--site-nav theme--dark">
      <img
        class="logo"
        src="../assets/bss_logo.png"
        alt="Logo of the School of Business and Social Sciences at Aarhus Universitet"
        @click="push('/bss')"
      >
      <div class="nav__site">
        <div class="nav__items">
          <a
            class="nav__item"
            :class="{'nav__item--active': index === activeIndex}"
            v-for="(route, index) in menuRoutes"
            :key="index"
            @click="push(route.path)"
          >
            {{route.name}}
            <span
              v-if="route.comingSoon"
              class="tag">coming soon...</span>
          </a>
        </div>
      </div>
    </div>
    <div class="row section-title">
      <div class=" large-10 medium-10 columns">
        <h1
          class="association"
          @click="push('/ps')"
        >
          Department of Political Science
        </h1>
      </div>
      <div class="large-2 medium-2 small-2 columns seal text-right">

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
  .logo {
    height: 4rem;
    margin-right: 2rem;
  }
  .tag {
    position: absolute;
    margin-left: .5em;
    z-index: 1;
    font-size: 60%;
    background-color: #ffffd1;
    color: black;
    border-radius: 1em;
    padding: 0 .5em;
    transform: rotate(30deg);
  }
  .association {
    font-size: 100%;
    padding: var(--spacing-m4) var(--spacing-0) 0 var(--spacing-0);
  }
  .section-title {
    border-bottom: 3px solid #002546;
  }
</style>
