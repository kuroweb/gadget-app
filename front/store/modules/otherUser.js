export const state = () => ({
  otherUser: {},
  isFollowed: null,
})

export const getters = {
  otherUser(state) {
    return state.otherUser
  },
  following(state) {
    return state.otherUser.following
  },
  followers(state) {
    return state.otherUser.followers
  },
  isFollowed(state) {
    return state.isFollowed
  }
}

export const actions = {
  setOtherUser ({ commit }, payload) {
    commit('setOtherUser', payload)
  },
  setIsFollowed ({ commit }, payload) {
    commit('setIsFollowed', payload)
  },
}

export const mutations = {
  setOtherUser (state, payload)  {
    state.otherUser = payload
  },
  setIsFollowed (state, payload) {
    state.isFollowed = payload
  },
}