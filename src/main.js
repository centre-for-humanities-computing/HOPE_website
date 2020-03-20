import Vue from 'vue'
import App from './App'
import router from './router'
import store from './modules'
import moment from 'moment'
import _ from 'lodash'
import AsyncComputed from 'vue-async-computed'

Vue.config.productionTip = false

Vue.use(AsyncComputed)

// prefetch frequently used components
Vue.component('vRepoFile', () => import('./components/vRepoFile.vue'))
Vue.component('vHeading', () => import('./components/vHeading.vue'))

// prefetch self-nestable components
Vue.component('MarkdownItOutput', () => import('./components/MarkdownIt/MarkdownItOutput.vue'))
Vue.component('Excursions', () => import('./components/MarkdownIt/components/Excursions.vue'))

Vue.prototype.moment = moment
Vue.prototype._ = _

Vue.mixin({ // todo: review
  data() {
    return {
      windowWidth: 100,
      windowHeight: 100
    }
  }
})

/* eslint-disable no-new */
new Vue({
  render: h => h(App),
  store,
  router
}).$mount('#app')
