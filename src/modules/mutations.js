import * as actions from './types'
import Vue from 'vue'
const mutations = {
  [actions.SET_ACTIVE_ROUTE](state, value){
    Vue.set(state, 'activeRoute', value)
  },
  [actions.SET_LANGUAGE](state, value) {
    Vue.set(state, 'language', value)
  }
}

export default mutations
