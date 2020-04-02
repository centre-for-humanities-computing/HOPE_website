import _ from 'lodash'
import Vue from 'vue'
import Router from 'vue-router'
import store from './modules'
import * as boxActions from './modules/box/types'
import * as actions from './modules/types'
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
    path: '/dashboard',
    name: 'Dashboard',
    inMenu: true,
    comingSoon: true,
    component: () => import(/* webpackChunkName: "search" */ './components/vDashboard.vue')
  },
  {
    path: '/publications',
    name: 'Publications',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/vPublications.vue')
  },
  {
    path: '/coronaCrisisInDK',
    name: 'CoronaCrisisInDK',
    component: () => import(/* webpackChunkName: "search" */ './components/CoronaCrisisInDK.vue')
  },
  {
    path: '/coronaKrisenIDK',
    name: 'CoronaKrisenIDK',
    component: () => import(/* webpackChunkName: "search" */ './components/CoronaKrisenIDK.vue')
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

const router = new Router({routes})
const boxFaces = ['front', 'back', 'right', 'left', 'top', 'bottom']
const pathFaces = {
  '/': 'front',
  '/about': 'top',
  '/news': 'right',
  '/publications': 'back',
  '/dashboard': 'bottom',
  '/coronaCrisisInDK': 'left',
  '/coronaKrisenIDK': 'bottom',
  '/md': 'bottom',
  '/search': 'bottom',
}

function getComponent(route) {
  let component = route.matched[0]
  const path = component.path || '/' // home path is just empty, but route configured with /
  if (component) {
    const matchingRoute = router.options.routes.find(route => route.path === path)
    if (matchingRoute) {
      component = matchingRoute.component
    }
  }
  return component
}
function maintainViews(to, from) {
  if (from.matched[0]) {
    _.assign(to.matched[0].components, from.matched[0].components)
  }
}
function setToFaceComponents(to, from, toFace) {
  maintainViews(to, from)
  let faces = getOtherFaces()
  faces.splice(toFace)
  to.matched[0].components[toFace] = getComponent(to)
}

function findRenderedViewFace(to, from) {
  let routeViews = from.matched[0]
  let componentView

  if (routeViews) {
    const components = routeViews.components

    for (let view in components) {
      //console.log('view', view, components.view)

      if (components[view].name.toLowerCase() === to.path) { // todo: smell: obscure dependency of route name and path
        componentView = view
      }
    }
  }
  return componentView
}
function getRandomOtherFace() {
  let otherFaces = getOtherFaces()
  return otherFaces.splice(Math.floor(Math.random() * otherFaces.length), 1)[0]
}
function getOtherFaces() {
  let fromFace = 0
  if (store.state) fromFace = store.state.box.face
  let otherFaces = _.clone(boxFaces)
  if (boxFaces.indexOf(fromFace) !== -1) {
    otherFaces.splice(boxFaces.indexOf(fromFace), 1)
  }
  return otherFaces
}
function getViewFace(to, from) {
  let toFace = pathFaces[to.path]
  if (!toFace) {
    toFace = findRenderedViewFace(to, from)
  }
  if (!toFace) {
    toFace = getRandomOtherFace(to, from)
  }
  return toFace
}
function turnBoxToShowView(toFace) {
  store.commit(`box/${boxActions.SET_BOX_FACE}`, toFace) // turn router-view box to requested view
}
function mapViewsToBoxFaces(to, from, next) {
  const toFace = getViewFace(to, from)
  setToFaceComponents(to, from, toFace)
  turnBoxToShowView(toFace)
  store.commit(actions.SET_ACTIVE_ROUTE, to.path)
  next()
}
function prepareNavigation(from, to, next) {
  mapViewsToBoxFaces(from, to , next)
}

router.beforeEach(prepareNavigation)
export default router
