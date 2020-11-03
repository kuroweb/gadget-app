export const state = () => ({
  otherUser: {}
})

export const getters = {
  otherUser(state) {
    return state.otherUser
  }
}

export const mutations = {
  setUser: (state, userData) => {
    state.otherUser = userData
  }
}