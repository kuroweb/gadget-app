export const state = () => ({
  // ローディング画面
  loading: false,
  // フラッシュメッセージ
  flash: {
    status: false,
    message: "",
  },
  error: false
})

export const getters = {

  loading(state) {
    return state.loading
  },

  flash(state) {
    return state.flash
  },

  error(state) {
    return state.error
  }
}

export const actions = {

  setLoading({commit}, payload) {
    commit('setLoading', payload)
  },

  setFlash({commit}, payload) {
    commit('setFlash', payload)
  },

  setError({commit}, payload) {
    commit('setError', payload)
  }
}

export const mutations = {

  setLoading (state, payload) {
    state.loading = payload
  },

  setFlash (state, payload) {
    state.flash = payload
  },

  setError (state, payload) {
    state.error = payload
  }
}