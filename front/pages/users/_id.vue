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
                      <p>{{ otherUser.following.length }}人</p>
                    </v-col>
                    <v-col>
                      <p>フォロワー</p>
                      <p>{{ otherUser.followers.length }}人</p>
                    </v-col>
                  </v-row>
                </v-col>
                <v-col cols="12" v-if="isAuthenticated && currentUser.id !== otherUser.id">
                  <v-row justify="center">
                    <v-btn
                      v-if="!otherUser.isFollowed"
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
              @change="changeUserNewPosts"
              class="ma-0 pa-0"
            >
              つぶやき
              <v-icon>mdi-clock-time-eight</v-icon>
            </v-tab>
            <v-tab
              @change="changeUserLikedPosts"
              class="ma-0 pa-0"
            >
              いいね
              <v-icon>mdi-heart-box</v-icon>
            </v-tab>
            <v-tab
              @change="changeUserGadgets"
              class="ma-0 pa-0"
            >
              持ち物
              <v-icon>mdi-account-heart</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item class="pa-1">
              <UserNewPosts
                :load="loadUserNewPosts"
              />
            </v-tab-item>
            <v-tab-item class="pa-1">
              <UserLikedPosts
                :load="loadUserLikedPosts"
              />
            </v-tab-item>
            <v-tab-item class="pa-1">
              <UserGadgets
                :load="loadUserGadgets"
              />
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
import UserNewPosts from '~/components/organisms/users/UserNewPosts.vue'
import UserLikedPosts from '~/components/organisms/users/UserLikedPosts.vue'
import UserGadgets from '~/components/organisms/users/UserGadgets.vue'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    ErrorCard,
    UserNewPosts,
    UserLikedPosts,
    UserGadgets
  },
  data () {
    return {
      tab: null,
      loadUserNewPosts: false,
      loadUserLikedPosts: false,
      loadUserGadgets: false
    }
  },
  async fetch({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      .then(res => {
        store.dispatch('modules/otherUser/setData', res)
        store.commit('modules/info/setError', false)
      })
      .catch(error => {
        store.commit('modules/info/setError', true)
      })
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      otherUser: 'modules/otherUser/data',
      error: 'modules/info/error'
    })
  },
  methods: {
    ...mapActions({
      setData: 'modules/otherUser/setData',
    }),
    async follow() {
      await this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
      })
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}`)
        .then(res => {
          this.setData(res)
        })
    },
    async unfollow() {
      await this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/relationships/delete', {
        params: {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
        }
      })
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}`)
        .then(res => {
          this.setData(res)
        })
    },
    changeUserNewPosts () {
      this.loadUserNewPosts = !this.loadUserNewPosts
    },
    changeUserLikedPosts () {
      this.loadUserLikedPosts = !this.loadUserLikedPosts
    },
    changeUserGadgets () {
      this.loadUserGadgets = !this.loadUserGadgets
    },
  }
}
</script>
<style scoped>
</style>