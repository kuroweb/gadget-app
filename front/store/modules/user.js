import firebaseApp from "@/plugins/firebase"
import Cookies from 'js-cookie'

export const state = () => ({
  // firebaseの認証情報
  user: null,
  // ローディング画面
  loading: false,
  // フラッシュメッセージ
  flash: {
    status: false,
    message: "",
  },
  userData: null,
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

  userId(state) {
    if (state.userData && state.userData.id) return state.userData.id
    else return null
  },

  userData(state) {
    if (state.userData) return state.userData
    else return null
  },

  // 要リファクタリング（index.jsに移動）
  loading(state) {
    return state.loading
  },
  // 要リファクタリング（index.jsに移動）
  flash(state) {
    return state.flash
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
    await dispatch('setUSER', userInfo)
    await dispatch('loadUSERDATA', uid)
    console.log('[STORE ACTIONS] - in login, response:', status)

  },

  async logout({commit, dispatch}) {
    console.log('[STORE ACTIONS] - logout')
    await firebaseApp.auth().signOut()

    Cookies.remove('access_token');
    commit('setUSER', null)
    commit('setUSERDATA', null)
  },

  setUSER({commit}, user) {
    console.log('[STORE ACTIONS] - saveUSER')
    commit('setUSER', user)
  },

  setLOADING({commit}, payload) {
    console.log('[STORE ACTIONS] - saveLOADING')
    commit('setLOADING', payload)
  },

  setFLASH({commit}, payload) {
    console.log('[STORE ACTIONS] - saveFLASH')
    commit('setFLASH', payload)
  },

  async loadUSERDATA ({ commit }, payload) {
    try {
      console.log('test')
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      const data = await this.$axios.$get(baseUrl + `/v1/users?uid=${payload}`)
      commit('setUSERDATA', data)
    } catch (e) {
      console.log(e)
    }
  }
}

export const mutations = {

  setUSER (state, user) {
    console.log('[STORE MUTATIONS] - setUSER:', user)
    state.user = user
  },

  setLOADING (state, payload) {
    console.log('[STORE MUTATIONS] - setLOADING;', payload)
    state.loading = payload
  },

  setFLASH (state, payload) {
    console.log('[STORE MUTATIONS] - setFLASH;', payload)
    state.flash = payload
  },
  setUSERDATA (state, payload) {
    state.userData = payload
  }
}
