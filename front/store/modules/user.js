import firebaseApp from "@/plugins/firebase"
import Cookies from 'js-cookie'

export const state = () => ({
  user: null,
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
}

export const actions = {

  async login({dispatch, state}, user) {
    console.log('[STORE ACTIONS] - login')
    const token = await firebaseApp.auth().currentUser.getIdToken(true)
    const userInfo = {
      email: user.email,
      uid: user.uid
    }

    Cookies.set('access_token', token) // saving token in cookie for server rendering
    await dispatch('setUSER', userInfo)
    console.log('[STORE ACTIONS] - in login, response:', status)

  },

  async logout({commit, dispatch}) {
    console.log('[STORE ACTIONS] - logout')
    await firebaseApp.auth().signOut()

    Cookies.remove('access_token');
    commit('setUSER', null)
  },

  setUSER({commit}, user) {
    console.log('[STORE ACTIONS] - saveUSER')
    commit('setUSER', user)
  },
}

export const mutations = {
  setUSER (state, user) {
    console.log('[STORE MUTATIONS] - setUSER:', user)
    state.user = user
  },
  setPROFILE (state, profile) {
    console.log('[STORE MUTATIONS] -  setPROFILE', profile)
    state.user.name = profile.name
  }
}
