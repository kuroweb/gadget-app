export const state = () => ({
  data: {},
  users: {}
})

export const getters = {
  data(state) {
    return state.data
  },
  users(state) {
    return state.users
  }
}

export const actions = {
  ///////////////////////////////////////////////////////////////////////////////////////////////
  // 詳細ページ用 / チェック済み
  ///////////////////////////////////////////////////////////////////////////////////////////////
  setData ({ commit, rootState }, user) {
    // isFollowedプロパティの追加
    user.isFollowed = false
    if (rootState.modules.user.data) {
      user.followers.forEach(f => {
        if (f.id === rootState.modules.user.data.id) {
          user.isFollowed = true
        }
      })
    }
    commit('setData', user)
  },


  ///////////////////////////////////////////////////////////////////////////////////////////////
  // 一覧ページ用 / 未チェック
  ///////////////////////////////////////////////////////////////////////////////////////////////
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
  ///////////////////////////////////////////////////////////////////////////////////////////////
  // 詳細ページ用 / チェック済み
  ///////////////////////////////////////////////////////////////////////////////////////////////
  setData (state, user)  {
    state.data = user
  },

  ///////////////////////////////////////////////////////////////////////////////////////////////
  // 一覧ページ用 / 未チェック
  ///////////////////////////////////////////////////////////////////////////////////////////////
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