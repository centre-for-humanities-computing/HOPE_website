import Vue from 'vue'
import Vuex from 'vuex'

import getters from './getters'
import mutations from './mutations'
import actions from './actions'
import state from './state'

import box from './box'
import colors from './colors'
import markdownItTests from './markdownItTests'

const debug = process.env.NODE_ENV !== "production";

Vue.use(Vuex)

const store = new Vuex.Store({
  state,
  getters,
  mutations,
  actions,
  modules: {
    box,
    colors,
    markdownItTests,
  },
  strict: debug
})

export default store
