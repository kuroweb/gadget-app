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
  ////////////////
  // 詳細ページ用 //
  ////////////////
  setData ({ commit, rootState }, payload) {
    // ログイン中の場合は、いいね総数・いいね未・済のプロパティを追加
    payload.likedUsersCounts = payload.liked_users.length
    let isLikedPost = false
    if (rootState.modules.user.data) {
      payload.liked_users.forEach(user => {
        if (user.id === rootState.modules.user.data.id) {
          isLikedPost = true
        }
      })
    }
    payload.isLikedPost = isLikedPost
    // コメント総数プロパティを追加
    payload.commentCounts = payload.post_comments.length
    // 親コメント、子コメントで区別
    let parentComments = []
    let childComments = []
    payload.post_comments.forEach(comment => {
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
    payload.post_comments = commentData
    commit('setData', payload)
  },
  reloadPostByCreateComment ({ commit }, comment) {
    commit('reloadPostByCreateComment', comment)
  },
  reloadPostByDeleteComment ({ commit }, comment) {
    commit('reloadPostByDeleteComment', comment)
  },
  reloadPostByEditPost ({ commit }, post) {
    commit('reloadPostByEditPost', post)
  },
  reloadPostByDeletePost ({ commit }, postId) {
    commit('reloadPostByDeletePost', postId)
  },
  reloadPostByCreatePost ({ commit }, post) {
    commit('reloadPostByCreatePost', post)
  },
  reloadPostByLikedPost ({ commit }, post) {
    commit('reloadPostByLikedPost', post)
  },
  reloadPostByDisLikedPost ({ commit }, post) {
    commit('reloadPostByDisLikedPost', post)
  },
  
  ////////////////
  // 一覧ページ用 //
  ////////////////
  setPosts ({ commit, rootState }, posts) {
    // いいね総数、いいね未・済のプロパティを追加
    const likeData = []
    posts.forEach(post => {
      post.likedUsersCounts = post.liked_users.length
      let isLikedPost = false
      if (rootState.modules.user.data) {
        post.liked_users.forEach(user => {
          if (user.id === rootState.modules.user.data.id) {
            isLikedPost = true
          }
        })
      }
      post.isLikedPost = isLikedPost
      likeData.push(post)
    })
    // コメント総数プロパティを追加
    posts.forEach(post => {
      post.commentCounts = post.post_comments.length
    })
    // 投稿へのコメントを整理
    const commentData = []
    posts.forEach(post => {
      // 親コメント、子コメントで区別
      let parentComments = []
      let childComments = []
      post.post_comments.forEach(comment => {
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
      post.post_comments = result
      commentData.push(post)
    })
    commit('setPosts', commentData)
  },
  reloadPostsByCreateComment ({ commit }, comment) {
    commit('reloadPostsByCreateComment', comment)
  },
  reloadPostsByDeleteComment ({ commit }, comment) {
    commit('reloadPostsByDeleteComment', comment)
  },
  reloadPostsByEditPost ({ commit }, postId) {
    commit('reloadPostsByEditPost', postId)
  },
  reloadPostsByDeletePost ({ commit }, postId) {
    commit('reloadPostsByDeletePost', postId)
  },
  reloadPostsByCreatePost ({ commit }, post) {
    commit('reloadPostsByCreatePost', post)
  },
  reloadPostsByLikedPost ({ commit }, post) {
    commit('reloadPostsByLikedPost', post)
  },
  reloadPostsByDisLikedPost ({ commit }, post) {
    commit('reloadPostsByDisLikedPost', post)
  },
  reloadPostsByPageScrolling ({ commit, rootState }, posts) {
    // いいね総数、いいね未・済のプロパティを追加
    const likeData = []
    posts.forEach(post => {
      post.likedUsersCounts = post.liked_users.length
      let isLikedPost = false
      if (rootState.modules.user.data) {
        post.liked_users.forEach(user => {
          if (user.id === rootState.modules.user.data.id) {
            isLikedPost = true
          }
        })
      }
      post.isLikedPost = isLikedPost
      likeData.push(post)
    })
    commit('reloadPostsByPageScrolling', posts)
  }
}

export const mutations = {
  ////////////////
  // 詳細ページ用 //
  ////////////////
  setData (state, payload) {
    state.data = payload
  },
  reloadPostByCreateComment (state, comment) {
    state.data.commentCounts += 1
    if (comment.reply_comment_id === null) {
      comment.childComments = []
      state.data.post_comments.push(comment)
    } else {
      state.data.post_comments.forEach(c => {
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
  },
  reloadPostByDeleteComment (state, comment) {
    // 親コメントの場合
    if (comment.reply_comment_id === null) {
      state.data.post_comments.forEach((c, index) => {
        if (c.id === comment.id) {
          // コメント数の集計
          let newCommentCounts = 0
          //// 子コメントが存在する場合
          if ('childComments' in c) {
            newCommentCounts = 1
            newCommentCounts += c.childComments.length
          //// 子コメントが存在しない場合
          } else {
            newCommentCounts = 1
          }
          state.data.post_comments.splice(index, 1)
          state.data.commentCounts -= newCommentCounts
        }
      })
    // 子コメントの場合
    } else {
      state.data.post_comments.forEach(c => {
        if ('childComments' in c) {
          c.childComments.forEach((child, index) => {
            if (child.id === comment.id) {
              c.childComments.splice(index, 1)
              state.data.commentCounts -= 1
            }
          })
        }
      })
    }
  },
  reloadPostByEditPost (state, post) {
    state.data.images_url = post.images_url
    state.data.description = post.description
    state.data.tags = post.tags
  },
  reloadPostByLikedPost (state, post) {
    state.data.isLikedPost = true
    state.data.likedUsersCounts += 1
  },
  reloadPostByDisLikedPost (state, post) {
    state.data.isLikedPost = false
    state.data.likedUsersCounts -= 1
  },
  setLikedUsersCountUp (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        const count = post.likedUsersCounts += 1
        p.likedUsersCounts = count
      }
    })
  },
  setLikedUsersCountDown (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        const count = post.likedUsersCounts -= 1
        p.likedUsersCounts = count
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

  ////////////////
  // 一覧ページ用 //
  ////////////////
  setPosts (state, payload) {
    state.posts = payload
  },
  reloadPostsByCreateComment (state, comment) {
    state.posts.forEach(post => {
      if (post.id === comment.post_id) {
        // 親コメントの場合
        if (comment.reply_comment_id === null) {
          comment.childComments = []
          post.post_comments.push(comment)
          post.commentCounts += 1
        // 子コメントの場合
        } else {
          post.commentCounts += 1
          post.post_comments.forEach(c => {
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
  reloadPostsByDeleteComment (state, comment) {
    state.posts.forEach(post => {
      if (post.id === comment.post_id) {
        // 親コメントの場合
        if (comment.reply_comment_id === null) {
          post.post_comments.forEach((c, index) => {
            if (c.id === comment.id) {
              // コメント数の集計
              let newCommentCounts = 0
              //// 子コメントが存在する場合
              if ('childComments' in c) {
                newCommentCounts = 1
                newCommentCounts += c.childComments.length
              //// 子コメントが存在しない場合
              } else {
                newCommentCounts = 1
              }
              post.post_comments.splice(index, 1)
              post.commentCounts -= newCommentCounts
            }
          })
        // 子コメントの場合
        } else {
          post.post_comments.forEach(c => {
            if ('childComments' in c) {
              c.childComments.forEach((child, index) => {
                if (child.id === comment.id) {
                  c.childComments.splice(index, 1)
                  post.commentCounts -= 1
                }
              })
            }
          })
        }
      }
    })
  },
  reloadPostsByEditPost (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        p.images_url = post.images_url
        p.description = post.description
        p.tags = post.tags
      }
    })
  },
  reloadPostsByDeletePost (state, postId) {
    state.posts.forEach((p, index) => {
      if (p.id === postId) {
        state.posts.splice(index, 1)
      }
    })
  },
  reloadPostsByCreatePost (state, post) {
    post.isLikedPost = false
    post.likedUsersCounts = 0
    post.commentCounts = 0
    state.posts.unshift(post)
  },
  reloadPostsByLikedPost (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        p.isLikedPost = true
        p.likedUsersCounts += 1
      }
    })
  },
  reloadPostsByDisLikedPost (state, post) {
    state.posts.forEach(p => {
      if (p.id === post.id) {
        p.isLikedPost = false
        p.likedUsersCounts -= 1
      }
    })
  },
  reloadPostsByPageScrolling (state, posts) {
    posts.forEach(post => {
      state.posts.push(post)
    })
  }
}