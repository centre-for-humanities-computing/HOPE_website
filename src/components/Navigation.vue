<template>
  <div id=navigation class="card">
    <div class="pad left">
      <div class="title">
        <div class="link"
          @click="$router.push('/')"
        >
          HOPE
        </div>
      </div>
    </div>

    <div class="items">
      <div
        class="item"
        v-for="(route, index) in menuRoutes"
        :key="index"
      >
        <div
          class="link"
          text
          :value="isActivePath(route.path)"
          @click="push(route.path)"
        >
          {{route.title}}
        </div>
      </div>
    </div>

    <div class="pad right" />

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
      drawer: false
    }
  },
  methods: {
    isActivePath(path) {
      return this.$router.currentRoute.path === path
    },
    push(url) {
      this.drawer = false
      this.$router.push(url)
    },
  }
}
</script>
<style>
  #navigation {
    width: 100vm;
    display:grid;
    grid-template-columns: auto auto auto;
  }
  .items {
    display: flex;
    flex-direction: row;
  }
  .item {
    width: 100%;
    text-align: center;
  }
</style>
