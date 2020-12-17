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
  setData ({ commit, rootState }, payload) {
    // ログイン中の場合は、いいね総数・いいね未・済のプロパティを追加
    payload.liked_users_count = payload.liked_users.length
    let isLikedPost = false
    if ('id' in rootState.modules.user.data) {
      payload.liked_users.forEach(user => {
        if (user.id = rootState.modules.user.data.id) {
          isLikedPost = true
        }
      })
    }
    payload.isLikedPost = isLikedPost
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
      if (rootState.modules.user.data) {
        post.liked_users.forEach(user => {
          if (user.id = rootState.modules.user.data.id) {
            isLikedPost = true
          }
        })
      }
      post.isLikedPost = isLikedPost
      likeData.push(post)
    })
    // コメント総数プロパティを追加
    posts.forEach(post => {
      post.commentCounts = post.comments.length
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
  reloadPostsByCreate ({ commit }, comment) {
    commit('reloadPostsByCreate', comment)
  },
  reloadPostsByDelete ({ commit }, comment) {
    commit('reloadPostByDelete', comment)
  },
  reloadPostByCreate ({ commit }, comment) {
    commit('reloadPostByCreate', comment)
  },
  reloadPostByDelete ({ commit }, comment) {
    commit('reloadPostByDelete', comment)
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
  setData (state, payload) {
    state.data = payload
  },
  setPosts (state, payload) {
    state.posts = payload
  },
  reloadPostsByCreate (state, comment) {
    state.posts.forEach(post => {
      if (post.id === comment.post_id) {
        post.commentCounts += 1
        if (comment.reply_comment_id === null) {
          post.comments.push(comment)
        } else {
          post.comments.forEach(c => {
            if (c.id === comment.reply_comment_id) {
              if ('childComments' in c) {
                c.childComments.push(comment)
              } else {
                c.childComments = []
                c.childComments.push(comment)
              }
            }
          })
        }
      }
    })
  },
  reloadPostsByDelete (state, comment) {
    state.posts.forEach(post => {
      if (post.id === comment.post_id) {
        if (comment.reply_comment_id === null) {
          post.comments.forEach((c, index) => {
            if (c.id === comment.id) {
              post.comments.splice(index, 1)
              post.commentCounts -= 1
            }
          })
        } else {
          post.comments.forEach(c => {
            if ('childComments' in c) {
              c.childComments.forEach((child, index) => {
                if (child.id === comment.id) {
                  c.childComments.splice(index, 1)
                  post.commentCounte -= 1
                }
              })
            }
          })
        }
      }
    })
  },
  reloadPostByCreate (state, comment) {
    if (state.data.id === comment.post_id) {
      state.data.commentCounts += 1
      if (comment.reply_comment_id === null) {
        state.data.comments.push(comment)
      } else {
        state.data.comments.forEach(c => {
          if (c.id === comment.reply_comment_id) {
            if ('childComments' in c) {
              c.childComments.push(comment)
            } else {
              c.childComments = []
              c.childComments.push(comment)
            }
          }
        })
      }
    }
  },
  reloadPostByDelete (state, comment) {
    if (state.data.id === comment.post_id) {
      if (comment.reply_comment_id === null) {
        state.data.comments.forEach((c, index) => {
          if (c.id === comment.id) {
            state.data.comments.splice(index, 1)
            state.data.commentCounts -= 1
          }
        })
      } else {
        state.data.comments.forEach(c => {
          if ('childComments' in c) {
            c.childComments.forEach((child, index) => {
              if (child.id === comment.id) {
                c.childComments.splice(index, 1)
                state.data.commentCounte -= 1
              }
            })
          }
        })
      }
    }
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