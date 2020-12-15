export const state = () => ({
  data: {}
})

export const getters = {
  data(state) {
    return state.data
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
  }
}

export const mutations = {
  setData (state, payload) {
    state.data = payload
  }
}