export const state = () => ({
  post: null,
})

export const getters = {
  post(state) {
    return state.post
  }
}

export const actions = {

}

export const mutations = {
  setPOST (state, payload) {
    state.post = payload
  }
}
