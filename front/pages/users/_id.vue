<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="ユーザーが存在しません。"
    />
    <v-row justify="center">
      <v-col xl="4" lg="4" sm="8" cols="12">
        <v-card v-if="!error">
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>
              {{ otherUser.name }} さんのプロフィール
            </v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <v-row justify="center">
                    <v-avatar 
                      size="62"
                    >
                      <img 
                        v-if="otherUser.avatar_url"
                        :src="otherUser.avatar_url"
                        alt="Avatar"
                      >
                      <img
                        v-else
                        src="~/assets/images/default_icon.jpeg"
                        alt="Avatar"
                      >
                    </v-avatar>
                  </v-row>
                </v-col>
                <v-col cols="12">
                  <v-row justify="center">
                    <h3>{{ otherUser.name }} さん</h3>
                  </v-row>
                </v-col>
                <v-col cols="12">
                  <v-row justify="center">
                    <p>{{ otherUser.profile }}</p>
                  </v-row>
                </v-col>
                <v-col cols="12">
                  <v-row>
                    <v-col>
                      <p>フォロー</p>
                      <p>{{ following.length }}人</p>
                    </v-col>
                    <v-col>
                      <p>フォロワー</p>
                      <p>{{ followers.length }}人</p>
                    </v-col>
                  </v-row>
                </v-col>
                <v-col cols="12" v-if="isAuthenticated && currentUser.id !== otherUser.id">
                  <v-row justify="center">
                    <v-btn
                      v-if="!isFollowed"
                      color="success"
                      @click="follow"
                    >
                      フォローする
                    </v-btn>
                    <v-btn
                      v-else
                      color="white--text red"
                      @click="unfollow"
                    >
                      フォロー解除
                    </v-btn>
                  </v-row>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
        </v-card>
        <!-- <v-card class="mx-auto ma-5">
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>
              {{ otherUser.name }} さんのガジェット
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-card flat class="mx-auto ma-5">
                  <span>一覧</span>
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
        <v-card class="mx-auto">
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>
              {{ otherUser.name }} さんの投稿一覧
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col cols="12">
                <MicroPostCard
                  v-for="post in posts"
                  :key="post.id"
                  :post="post"
                />
              </v-col>
            </v-row>
          </v-container>
        </v-card> -->
      </v-col>
      <v-col xl="6" lg="6" sm="8" cols="12">
        <v-card class="mx-auto">
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="cyan darken-1"
            color="white"
            slider-color="orange"
            icons-and-text
          >
            <v-tab
              class="ma-0 pa-0"
            >
              投稿
              <v-icon>mdi-clock-time-eight</v-icon>
            </v-tab>
            <v-tab

              class="ma-0 pa-0"
            >
              持ち物
              <v-icon>mdi-account-heart</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item class="pa-1">
              <MicroPostCard
                v-for="post in posts"
                :key="post.id"
                :post="post"
              />
            </v-tab-item>
            <v-tab-item class="pa-1">
              <!-- <GadgetCard
                v-for="(gadget, index) in gadgets"
                :key="index"
                :gadget="gadget"
              /> -->
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import _ from 'lodash'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import GadgetCard from '~/components/organisms/GadgetCard.vue'
import MicroPostCard from '~/components/organisms/MicroPostCard.vue'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    ErrorCard,
    MicroPostCard,
    GadgetCard
  },
  data () {
    return {
      isFollowed: false,
      editDialog: false,
      deleteDialog: false,
      tab: null
    }
  },
  async fetch({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      .then(res => {
        // アクセス先ユーザーの基本情報をコミット
        const data = {
          id: res.id,
          name: res.name,
          profile: res.profile,
          avatar_url: res.avatar_url,
        }
        store.commit('modules/otherUser/setData', data)
        // アクセス先ユーザーのフォロー・フォロワー情報をコミット
        store.commit('modules/otherUser/setFollowing', res.following)
        store.commit('modules/otherUser/setFollowers', res.followers)
        // アクセス先ユーザーの投稿情報をコミット
        store.dispatch('modules/post/setPosts', res.posts)
        store.commit('modules/info/setError', false)
      })
      .catch(error => {
        store.commit('modules/info/setError', true)
      })
  },
  async mounted () {
    if (this.currentUser !== null) {
      await this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/users/isFollowed', {
        params: {
          current_user: this.$store.state.modules.user.data.id,
          other_user: this.$store.state.modules.otherUser.data.id
        }
      })
        .then(res => {
          this.isFollowed = res
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      otherUser: 'modules/otherUser/data',
      following: 'modules/otherUser/following',
      followers: 'modules/otherUser/followers',
      posts: 'modules/post/posts',
      error: 'modules/info/error'
    })
  },
  methods: {
    ...mapActions({
      setFollowers: 'modules/otherUser/setFollowers',
      setLikedUsersCountUp: 'modules/otherUser/setLikedUsersCountUp',
      setLikedUsersCountDown: 'modules/otherUser/setLikedUsersCountDown',
      setIsLikedPostTrue: 'modules/otherUser/setIsLikedPostTrue',
      setIsLikedPostFalse: 'modules/otherUser/setIsLikedPostFalse',
    }),

    // フォローボタン関連
    follow() {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
      })
        .then(res => {
          this.isFollowed = true
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then(res => {
          this.setFollowers (res)
          console.log('フォローに成功')
        })
        .catch(() => {
          console.log("フォローに失敗")
        })
    },
    unfollow() {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/relationships/delete', {
        params: {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
        }
      })
        .then(res => {
          this.isFollowed = false
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then(res => {
          this.setFollowers (res)
          console.log('フォロー解除に成功')
        })
        .catch(() => {
          console.log("フォロー解除に失敗")
        })
    },

    // ダイアログ関連
    // MicroPostCardに移植予定
    // 現在使用していないが動作するはず。
    openEditDialog (post) {
      this.postId = post.id
      this.editDialog = true
    },
    openDeleteDialog (post) {
      this.postId = post.id
      this.deleteDialog = true
    },

    // ライクボタン関連
    // MicroPostCardに移植予定
    // 現在使用していないが動作するはず。
    createLikePost (post) {
      const likeParams = {
        user_id: this.currentUser.id,
        post_id: post.id
      }
      this.$axios.$post(process.env.BROWSER_BASE_URL + `/v1/likes/`, { like: likeParams })
        .then(() => {
          this.setLikedUsersCountUp (post)
          this.setIsLikedPostTrue (post)
        })
    },
    destroyLikePost (post) {
      const likeParams = {
        user_id: this.currentUser.id,
        post_id: post.id
      }
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/likes/delete', { params: { like: likeParams } })
        .then(res => {
          this.setLikedUsersCountDown (post)
          this.setIsLikedPostFalse (post)
        })
    }
  }

}
</script>
<style scoped>

</style>