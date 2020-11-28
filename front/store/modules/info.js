export const state = () => ({
  // ローディング画面
  loading: false,
  // フラッシュメッセージ
  flash: {
    status: false,
    message: "",
  }
})

export const getters = {

  loading(state) {
    return state.loading
  },

  flash(state) {
    return state.flash
  }
}

export const actions = {

  setLoading({commit}, payload) {
    commit('setLoading', payload)
  },

  setFlash({commit}, payload) {
    commit('setFlash', payload)
  }
}

export const mutations = {

  setLoading (state, payload) {
    state.loading = payload
  },

  setFlash (state, payload) {
    state.flash = payload
  }
}