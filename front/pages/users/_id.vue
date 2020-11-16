<template>
  <v-container>
    <ErrorCard
      :display="!otherUser.id"
      title="404NotFound"
      message="ユーザーが存在しません。"
    />
    <v-card v-if="otherUser.id" class="mx-auto mt-5 pa-5" width="700px">
      <v-card-text>
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
        <v-row justify="center">
          <h3>{{ otherUser.name }} さん</h3>
        </v-row>
        <v-row justify="center">
          <p>{{ otherUser.profile }}</p>
        </v-row>
        <v-row justify="center">
          <v-col>
            <p>フォロー</p>
            <p>{{ following.length }}人</p>
          </v-col>
          <v-col>
            <p>フォロワー</p>
            <p>{{ followers.length }}人</p>
          </v-col>
        </v-row>
        <v-row justify="center">
          <div
            v-if="isAuthenticated && userData.id !== otherUser.id"
          >
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
          </div>
        </v-row>
      </v-card-text>
    </v-card>
    <v-card
      v-for="post in this.posts"
      :key="post.id"
      class="mx-auto mt-5 pa-5" width="700px"
    >
      <v-card-title>
        <v-row>
          <v-col>
            <v-avatar 
              size="62"
            >
              <img 
                v-if="post.user.avatar_url"
                :src="post.user.avatar_url"
                alt="Avatar"
              >
              <img
                v-else
                src="~/assets/images/default_icon.jpeg"
                alt="Avatar"
              >
            </v-avatar>
          </v-col>
          <v-col>
            <h3>{{ post.user.name }}</h3>
          </v-col>
        </v-row>
      </v-card-title>
      <v-card-text>
        <v-row>
          <p>{{ post.description }}</p>
        </v-row>
        <v-row
          justify="center"
          v-if="post.images_url !== null"
        >
          <v-avatar v-if="post.images_url.length > 0">
            <img :src="post.images_url[0]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 1">
            <img :src="post.images_url[1]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 2">
            <img :src="post.images_url[2]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 3">
            <img :src="post.images_url[3]">
          </v-avatar>
        </v-row>
      </v-card-text>



    </v-card>

  </v-container>
</template>
<script>
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    ErrorCard
  },
  data () {
    return {
    }
  },
  async fetch({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      .then((res) => {
        store.commit('modules/otherUser/setOtherUser', res)
        return $axios.$get(baseUrl + `/v1/users/${params.id}/following`)
      })
      .then((res) => {
        store.commit('modules/otherUser/setFollowing', res)
        return $axios.$get(baseUrl + `/v1/users/${params.id}/followers`)
      })
      .then((res) => {
        store.commit('modules/otherUser/setFollowers', res)
        if (store.state.modules.user.userData !== null ) {
          return $axios.$get(baseUrl + '/v1/isFollowed', {
            params: {
              user_id: store.state.modules.user.userData.id,
              follow_id: store.state.modules.otherUser.otherUser.id
            }
          })
        } else {
          return false
        }
      })
      .then((res) => {
        store.commit('modules/otherUser/setIsFollowed', Boolean(res))
        return $axios.$get(baseUrl + `/v1/users/${params.id}/posts`)
      })
      .then((res) => {
        store.commit('modules/otherUser/setPosts', res)
      })
      .catch((error) => {
        console.log('ユーザーが存在しません。')
      })
  },

  computed: {
    ...mapGetters({
      isAuthenticated: 'modules/user/isAuthenticated',
      otherUser: 'modules/otherUser/otherUser',
      userData: 'modules/user/userData',
      following: 'modules/otherUser/following',
      followers: 'modules/otherUser/followers',
      isFollowed: 'modules/otherUser/isFollowed',
      posts: 'modules/otherUser/posts'
    }),
  },
  methods: {
    ...mapActions('modules/otherUser', ['setIsFollowed', 'setFollowers']),
    follow() {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
        user_id: this.userData.id,
        follow_id: this.otherUser.id
      })
        .then(() => {
          this.setIsFollowed (true)
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then((res) => {
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
          user_id: this.userData.id,
          follow_id: this.otherUser.id
        }
      })
        .then(() => {
          this.setIsFollowed (false)
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then((res) => {
          this.setFollowers (res)
          console.log('フォロー解除に成功')
        })
        .catch(() => {
          console.log("フォロー解除に失敗")
        })
    }
  }
}
</script>
<style>

</style>