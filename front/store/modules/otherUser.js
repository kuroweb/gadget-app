export const state = () => ({
  data: {},
  following: {},
  followers: {},
  posts: {}
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
  },
  posts(state) {
    return state.posts
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
  },
  setPosts ({ commit, rootState }, posts) {
    const data = []
    posts.forEach(post => {
      post.liked_users_count = post.liked_users.length
      let isLikedPost = false
      if (rootState.modules.user.data !== null) {
        post.liked_users.forEach(user => {
          if (user.id = rootState.modules.user.data.id) {
            isLikedPost = true
          }
        })
      }
      post.isLikedPost = isLikedPost
      data.push(post)
    })
    commit('setPosts', data)
  },
  setLikedUsersCountUp ({ commit }, post) {
    commit('setLikedUsersCountUp', post)
  },
  setLikedUsersCountDown ({ commit }, post) {
    commit('setLikedUsersCountDown', post)
  },
  setIsLikedPostTrue ({ commit }, post) {
    commit('setIsLikedPostTrue', post)
  },
  setIsLikedPostFalse ({ commit }, post) {
    commit('setIsLikedPostFalse', post)
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
  },
  setPosts (state, payload) {
    state.posts = payload
  },
  setLikedUsersCountUp (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        const count = post.liked_users_count += 1
        p.liked_users_count = count
      }
    })
  },
  setLikedUsersCountDown (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        const count = post.liked_users_count -= 1
        p.liked_users_count = count
      }
    })
  },
  setIsLikedPostTrue (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        p.isLikedPost = true
      }
    })
  },
  setIsLikedPostFalse (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        p.isLikedPost = false
      }
    })
  },
}