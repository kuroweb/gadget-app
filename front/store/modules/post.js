export const state = () => ({
  data: {},
  posts: {}
})

export const getters = {
  data(state) {
    return state.data
  },
  posts(state) {
    return state.posts
  }
}

export const actions = {
  setData ({ commit }, payload) {
    // 親コメント、子コメントで区別
    let parentComments = []
    let childComments = []
    payload.comments.forEach(comment => {
      if (comment.reply_comment_id === null) {
        parentComments.push(comment)
      } else {
        childComments.push(comment)
      }
    })
    // 親コメント内に子コメントを格納
    const commentData = []
    parentComments.forEach(p => {
      p.childComments = []
      childComments.forEach(c => {
        if (p.id === c.reply_comment_id) {
          p.childComments.push(c)
        }
      })
      commentData.push(p)
    })
    payload.comments = commentData
    commit('setData', payload)
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
}

export const mutations = {
  setData (state, payload) {
    state.data = payload
  },
  setPosts (state, payload) {
    state.posts = payload
  },
}