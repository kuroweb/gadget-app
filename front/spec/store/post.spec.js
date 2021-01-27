///////////////////////////
//  投稿データ関連のテスト  //
//////////////////////////
import Vuex from 'vuex'
import * as post from '~/store/modules/post'
import { createLocalVue } from '@vue/test-utils'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('APIから投稿データを取得 -> Vuex Action で isLikedプロパティとlikedUsersCountsプロパティを追加してストアにコミットする', () => {
  let store
  it('投稿をいいね済みの場合、isLikedプロパティ: true, likedUsersCounts: 1 となる', () => {
    // APIから取得するデータ
    const payload = {
      id: 1,
      description: "投稿内容",
      user_id: 1,
      created_at: "created_at",
      updated_at: "updated_at",
      images_url: null,
      user: {
        id: 1,
        name: "ユーザー名",
        email:"email@example.com",
        uid: "uid",
        profile: null,
        created_at: "created_at",
        updated_at: "updated_at",
        avatar_url: null
      },
      tags: [],
      liked_users: [
        {
          id: 1
        }
      ],
      post_comments: []
    }
    // store/post.js setData(payload)を実行した結果を想定したデータ
    const result = {
      id: 1,
      description: "投稿内容",
      user_id: 1,
      created_at: "created_at",
      updated_at: "updated_at",
      images_url: null,
      user: {
        id: 1,
        name: "ユーザー名",
        email:"email@example.com",
        uid: "uid",
        profile: null,
        created_at: "created_at",
        updated_at: "updated_at",
        avatar_url: null
      },
      tags: [],
      liked_users: [
        {
          id: 1
        }
      ],
      post_comments: [],
      likedUsersCounts: 1,
      isLikedPost: true,
      commentCounts: 0
    }
    // ログイン中のユーザーID
    const state = {
      modules: {
        user: {
          data: {
            id: 1
          }
        }
      }
    }
    // rootStateを含んだストアをモック
    store = new Vuex.Store({
      state,
      modules: {
        post
      }
    })
    // payloadのデータを使って setData を実行
    store.dispatch('setData', payload)
    // 想定データと比較。isLiked: true が追加されていればテスト成功
    expect(store.getters['data']).toEqual(result)
  })
  it('投稿をいいねしていない場合、isLikedプロパティ: false, likedUsersCounts: 0 となる。', () => {
    // APIから取得するデータ
    const payload = {
      id: 1,
      description: "投稿内容",
      user_id: 1,
      created_at: "created_at",
      updated_at: "updated_at",
      images_url: null,
      user: {
        id: 1,
        name: "ユーザー名",
        email:"email@example.com",
        uid: "uid",
        profile: null,
        created_at: "created_at",
        updated_at: "updated_at",
        avatar_url: null
      },
      tags: [],
      liked_users: [],
      post_comments: []
    }
    // store/post.js setData(payload)を実行した結果を想定したデータ
    const result = {
      id: 1,
      description: "投稿内容",
      user_id: 1,
      created_at: "created_at",
      updated_at: "updated_at",
      images_url: null,
      user: {
        id: 1,
        name: "ユーザー名",
        email:"email@example.com",
        uid: "uid",
        profile: null,
        created_at: "created_at",
        updated_at: "updated_at",
        avatar_url: null
      },
      tags: [],
      liked_users: [],
      post_comments: [],
      likedUsersCounts: 0,
      isLikedPost: false,
      commentCounts: 0
    }
    // ログイン中のユーザーID
    const state = {
      modules: {
        user: {
          id: 1
        }
      }
    }
    // rootStateを含んだストアをモック
    store = new Vuex.Store({
      state,
      modules: {
        post
      }
    })
    // payloadのデータを使って setData を実行
    store.dispatch('setData', payload)
    // 想定データと比較。isLiked: false が追加されていればテスト成功
    expect(store.getters['data']).toEqual(result)
  })
})