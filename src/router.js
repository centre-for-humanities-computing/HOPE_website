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
    title: 'HOPE',
    icon: 'home',
    inMenu: true,
    component: Home
  },
  {
    path: '/people',
    title: 'People',
    icon: 'people_alt',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/People.vue')
  },
  {
    path: '/resources',
    title: 'Resources',
    icon: 'extension',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/Resources.vue')
  },
  {
    path: '/contact',
    title: 'Contact',
    icon: 'contact_mail',
    inMenu: true,
    component: () => import(/* webpackChunkName: "search" */ './components/Contact.vue')
  },
  {
    path: '/md',
    title: 'MarkdownIt Tests',
    icon: 'spellcheck',
    inMenu: false,
    component: MarkdownItTests
  },
  {
    path: '/search',
    title: 'Search',
    icon: 'search',
    inMenu: false,
    component: () => import(/* webpackChunkName: "search" */ './components/Search.vue')
  },
  {
    path: '*',
    title: 'notFound',
    component: () => import('./components/notFound.vue')
  }
]

const router = new Router({routes})
const boxFaces = ['front', 'back', 'right', 'left', 'top', 'bottom']
const pathFaces = {
  '/': 'front',
  '/people': 'top',
  '/resources': 'right',
  '/contact': 'back',
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
    routeViews = routeViews.components
    for (let view in routeViews) {
      // console.log('routeViews[view]', routeViews[view])
      // console.log('to', to)

      if (routeViews[view].title.toLowerCase() === to.path) { // todo: smell: obscure dependency of title and route
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

router.beforeEach(mapViewsToBoxFaces)
export default router
