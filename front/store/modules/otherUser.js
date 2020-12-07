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
    // いいね総数、いいね未・済のプロパティを追加
    const likeData = []
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
      likeData.push(post)
    })
    // 投稿へのコメントを整理
    const commentData = []
    posts.forEach(post => {
      // 親コメント、子コメントで区別
      let parentComments = []
      let childComments = []
      post.comments.forEach(comment => {
        if (comment.reply_comment_id === null) {
          parentComments.push(comment)
        } else {
          childComments.push(comment)
        }
      })
      // 親コメント内に子コメントを格納
      const result = []
      parentComments.forEach(p => {
        p.childComments = []
        childComments.forEach(c => {
          if (p.id === c.reply_comment_id) {
            p.childComments.push(c)
          }
        })
        result.push(p)
      })
      post.comments = result
      commentData.push(post)
    })
    commit('setPosts', commentData)
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