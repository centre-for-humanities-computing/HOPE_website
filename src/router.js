import Vue from 'vue'
import Router from 'vue-router'
import Home from './components/Home.vue'
import MarkdownItTests from "./components/MarkdownIt/MarkdownItTests/MarkdownItTests"

Vue.use(Router)

export const routes = [
  {
    path: '/',
    name: 'HOPE',
    inMenu: true,
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/About.vue')
  },
  {
    path: '/news',
    name: 'News',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/vNews.vue')
  },
  {
    path: '/publications',
    name: 'Publications',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/vPublications.vue')
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    inMenu: true,
    beforeEnter() {location.href='https://hope-project.dk/dashboard'}
    //component: () => import(/* webpackChunkName: "search" */ './components/vDashboard.vue')
  },
  {
    path: '/coronaCrisisInDK',
    name: 'CoronaCrisisInDK',
    component: () => import('./components/CoronaCrisisInDK.vue')
  },
  {
    path: '/coronaKrisenIDK',
    name: 'CoronaKrisenIDK',
    component: () => import('./components/CoronaKrisenIDK.vue')
  },
  {
    path: '/document/:directory/:filename',
    name: 'document',
    component: () => import('./components/Document.vue'),
    props: true
  },
  {
    path: '/bss',
    name: 'BSS',
    beforeEnter() {location.href='https://bss.au.dk/en/'}
  },
  {
    path: '/ps',
    name: 'PS',
    beforeEnter() {location.href='https://ps.au.dk/en/'}
  },
  {
    path: '/md',
    name: 'MarkdownIt Tests',
    inMenu: false,
    component: MarkdownItTests
  },
  {
    path: '*',
    name: 'notFound',
    component: () => import('./components/notFound.vue')
  }
]

const router = new Router({
  routes,
  scrollBehavior: function(to, from, savedPosition) {
    if (to.hash) {
      return { selector: to.hash }
    } else {
      return { x: 0, y: 0 }
    }
  }
})

export default router
