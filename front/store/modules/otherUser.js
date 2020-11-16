export const state = () => ({
  otherUser: {},
  following: {},
  followers: {},
  isFollowed: null,
  posts: {}
})

export const getters = {
  otherUser(state) {
    return state.otherUser
  },
  following(state) {
    return state.following
  },
  followers(state) {
    return state.followers
  },
  isFollowed(state) {
    return state.isFollowed
  },
  posts(state) {
    return state.posts
  }
}

export const actions = {
  setOtherUser ({ commit }, payload) {
    commit('setOtherUser', payload)
  },
  setFollowing ({ commit }, payload) {
    commit('setFollowing', payload)
  },
  setFollowers ({ commit }, payload) {
    commit('setFollowers', payload)
  },
  setIsFollowed ({ commit }, payload) {
    commit('setIsFollowed', payload)
  },
  setPosts ({ commit }, payload) {
    commit('setPosts', payload)
  },
}

export const mutations = {
  setOtherUser (state, payload)  {
    state.otherUser = payload
  },
  setFollowing (state, payload) {
    state.following = payload
  },
  setFollowers (state, payload) {
    state.followers = payload
  },
  setIsFollowed (state, payload) {
    state.isFollowed = payload
  },
  setPosts (state, payload) {
    state.posts = payload
  },
}