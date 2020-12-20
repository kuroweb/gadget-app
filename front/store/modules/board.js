export const state = () => ({
  data: {},
  boards: {}
})

export const getters = {
  data(state) {
    return state.data
  },
  boards(state) {
    return state.boards
  }
}

export const actions = {
  setData ({ commit }, payload) {
    // コメント総数プロパティを追加
    payload.commentCounts = payload.board_comments.length
    // 親コメント、子コメントで区別
    let parentComments = []
    let childComments = []
    payload.board_comments.forEach(comment => {
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
    payload.board_comments = result
    commit('setData', payload)
  },
  setBoards ({ commit }, boards) {
    // コメント総数プロパティを追加
    boards.forEach(board => {
      board.commentCounts = board.board_comments.length
    })
    commit('setBoards', boards)
  },

  // 一覧ページ用
  reloadBoardsByCreateBoard ({ commit }, board) {
    commit('reloadBoardsByCreateBoard', board)
  },

  // 詳細ページ用
  reloadBoardByEditBoard ({ commit }, board) {
    commit('reloadBoardByEditBoard', board)
  }
}

export const mutations = {
  setData (state, payload) {
    state.data = payload
  },
  setBoards (state, payload) {
    state.boards = payload
  },

  // 一覧ページ用
  reloadBoardsByCreateBoard (state, board) {
    board.commentCounts = 0
    state.boards.unshift(board)
  },

  // 詳細ページ用
  reloadBoardByEditBoard (state, board) {
    state.data.images_url = board.images_url
    state.data.description = board.description
    state.data.title = board.title
    state.data.board_type = board.board_type
    state.data.tags = board.tags
  }
}