export const state = () => ({
  otherUser: {},
  following: null,
  followers: null
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
}

export const mutations = {
  setUser: (state, payload) => {
    state.otherUser = payload
  }
}