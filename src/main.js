import Vue from 'vue'
import App from './App'
import router from './router'
import store from './modules'
import moment from 'moment'
import _ from 'lodash'
import 'vue-simple-markdown/dist/vue-simple-markdown.css'
import VueSimpleMarkdown from 'vue-simple-markdown'
import vuetify from './plugins/vuetify';

Vue.config.productionTip = false

Vue.use(VueSimpleMarkdown)

// prefetch self-nested components
Vue.component('MarkdownItOutput', () => import('./components/MarkdownIt/MarkdownItOutput.vue'))
Vue.component('Excursions', () => import('./components/MarkdownIt/components/Excursions.vue'))

Vue.prototype.moment = moment
Vue.prototype._ = _

/* eslint-disable no-new */
new Vue({
  render: h => h(App),

  store,
  vuetify,

  router
}).$mount('#app')
