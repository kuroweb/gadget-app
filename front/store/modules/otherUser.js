export const state = () => ({
  data: {},
  following: {},
  followers: {}
})

export const getters = {
  data(state) {
    return state.data
  },
  following(state) {
    return state.following
  },
  followers(state) {
    return state.followers
  }
}

export const actions = {
  setData ({ commit }, payload) {
    commit('setData', payload)
  },
  setFollowing ({ commit }, payload) {
    commit('setFollowing', payload)
  },
  setFollowers ({ commit }, payload) {
    commit('setFollowers', payload)
  }
}

export const mutations = {
  setData (state, payload)  {
    state.data = payload
  },
  setFollowing (state, payload) {
    state.following = payload
  },
  setFollowers (state, payload) {
    state.followers = payload
  }
}