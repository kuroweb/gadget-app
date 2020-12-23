export const state = () => ({
  data: {},
  tags: {}
})

export const getters = {
  data(state) {
    return state.data
  }
}

export const actions = {
  setData ({ commit, rootState }, payload) {
    if (rootState.modules.user.data) {
      payload.isFollowed = false
      payload.users.forEach(user => {
        if (user.id === rootState.modules.user.data.id) {
          payload.isFollowed = true
        }
      })
    } else {
      payload.isFollowed = null
    }
    commit('setData', payload)
  }
}

export const mutations = {
  setData (state, payload) {
    state.data = payload
  }
}