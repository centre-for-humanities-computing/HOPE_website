import * as actions from './types'
import Vue from 'vue'
const mutations = {
  [actions.SET_ACTIVE_ROUTE](state, value){
    Vue.set(state, 'activeRoute', value)
  }
}

export default mutations
