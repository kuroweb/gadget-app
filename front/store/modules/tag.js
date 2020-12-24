export const state = () => ({
  data: {},
  tags: {}
})

export const getters = {
  data (state) {
    return state.data
  },
  tags (state) {
    return state.tags
  }
}

export const actions = {
  // 詳細ページ用
  setData ({ commit, rootState }, tag) {
    tag.isFollowed = false
    if (rootState.modules.user.data) {
      tag.users.forEach(user => {
        if (user.id === rootState.modules.user.data.id) {
          tag.isFollowed = true
        }
      })
    }
    commit('setData', tag)
  },
  setIsFollowed ({ commit }, payload) {
    commit('setIsFollowed', payload)
  },

  // 一覧ページ用
  setTags ({ commit, rootState }, tags) {
    // isFollowedプロパティの追加
    tags.forEach(tag => {
      tag.isFollowed = false
      if (rootState.modules.user.data) {
        tag.users.forEach(user => {
          if (user.id === rootState.modules.user.data.id) {
            tag.isFollowed = true
          }
        })
      }
    })
    commit('setTags', tags)
  },
  reloadTagsByFollow ({ commit }, tag) {
    commit('reloadTagsByFollow', tag)
  },
  reloadTagsByUnFollow ({ commit }, tag) {
    commit('reloadTagsByUnFollow', tag)
  },
  resetTags ({ commit }) {
    commit('resetTags')
  }
}

export const mutations = {
  // 詳細ページ用
  setData (state, tag) {
    state.data = tag
  },
  setIsFollowed (state, payload) {
    state.data.isFollowed = payload
  },

  // 一覧ページ用
  setTags (state, tags) {
    state.tags = tags
  },
  reloadTagsByFollow (state, tag) {
    state.tags.forEach(t => {
      if (t.id === tag.id) {
        t.isFollowed = true
      }
    })
  },
  reloadTagsByUnFollow (state, tag) {
    state.tags.forEach(t => {
      if (t.id === tag.id) {
        t.isFollowed = false
      }
    })
  },
  resetTags (state) {
    state.tags = {}
  }
}