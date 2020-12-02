import firebaseApp from "@/plugins/firebase"
import Cookies from 'js-cookie'

export const state = () => ({
  // firebaseの認証情報
  user: null,
  // APIにあるユーザー情報
  data: null,
})

export const getters = {

  uid(state) {
    if (state.user && state.user.uid) return state.user.uid
    else return null
  },

  user(state) {
    return state.user
  },

  isAuthenticated(state) {
    return !!state.user && !!state.user.uid
  },

  // 削除予定
  userId(state) {
    return state.data.id
  },

  data(state) {
    return state.data
  },
}

export const actions = {

  async login({dispatch, state}, user) {
    console.log('[STORE ACTIONS] - login')
    const token = await firebaseApp.auth().currentUser.getIdToken(true)
    const userInfo = {
      email: user.email,
      uid: user.uid
    }
    const uid = user.uid

    Cookies.set('access_token', token) // saving token in cookie for server rendering
    await dispatch('setUser', userInfo)
    await dispatch('loadData', uid)
    console.log('[STORE ACTIONS] - in login, response:', status)

  },

  async logout({commit, dispatch}) {
    console.log('[STORE ACTIONS] - logout')
    await firebaseApp.auth().signOut()

    Cookies.remove('access_token');
    commit('setUser', null)
    commit('setData', null)
  },

  setUser({commit}, user) {
    console.log('[STORE ACTIONS] - saveUser')
    commit('setUser', user)
  },

  async loadData ({ commit }, payload) {
    try {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      const data = await this.$axios.$get(baseUrl + `/v1/users?uid=${payload}`)
      commit('setData', data)
    } catch (e) {
      console.log(e)
    }
  }
}

export const mutations = {

  setUser (state, user) {
    console.log('[STORE MUTATIONS] - setUser:', user)
    state.user = user
  },
  
  setData (state, payload) {
    state.data = payload
  }
}
