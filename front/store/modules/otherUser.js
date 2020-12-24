export const state = () => ({
  data: {},
  following: {},
  followers: {},
  users: {}
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
  users(state) {
    return state.users
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


  // 一覧ページ用
  setUsers ({ commit, rootState }, users) {
    // isFollowedプロパティの追加
    users.forEach(user => {
      user.isFollowed = false
      if (rootState.modules.user.data) {
        user.followers.forEach(f => {
          if (f.id === rootState.modules.user.data.id) {
            user.isFollowed = true
          }
        })
      }
    })
    commit('setUsers', users)
  },
  reloadUsersByFollow ({ commit }, user) {
    commit('reloadUsersByFollow', user)
  },
  reloadUsersByUnFollow ({ commit }, user) {
    commit('reloadUsersByUnFollow', user)
  },
  resetUsers ({ commit }) {
    commit('resetUsers')
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

  // 一覧ページ用
  setUsers (state, users) {
    state.users = users
  },
  reloadUsersByFollow (state, user) {
    state.users.forEach(u => {
      if (u.id === user.id) {
        u.isFollowed = true
      }
    })
  },
  reloadUsersByUnFollow (state, user) {
    state.users.forEach(u => {
      if (u.id === user.id) {
        u.isFollowed = false
      }
    })
  },
  resetUsers (state) {
    state.users = {}
  }

}