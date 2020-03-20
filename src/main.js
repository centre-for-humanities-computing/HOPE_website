import Vue from 'vue'
import App from './App'
import router from './router'
import store from './modules'
import moment from 'moment'
import _ from 'lodash'
import 'vue-simple-markdown/dist/vue-simple-markdown.css'
import VueSimpleMarkdown from 'vue-simple-markdown'

Vue.config.productionTip = false

Vue.use(VueSimpleMarkdown)

// prefetch self-nested components
Vue.component('Md', () => import('./components/Md.vue'))
Vue.component('MarkdownItOutput', () => import('./components/MarkdownIt/MarkdownItOutput.vue'))
Vue.component('Excursions', () => import('./components/MarkdownIt/components/Excursions.vue'))

Vue.prototype.moment = moment
Vue.prototype._ = _

Vue.mixin({
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
