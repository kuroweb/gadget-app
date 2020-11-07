<template>
  <div>
    <ErrorCard
      :display="userNotFound"
      title="404NotFound"
      message="ユーザーが存在しません。"
    />
    <v-card v-if="!userNotFound" class="mx-auto mt-5 pa-5" width="700px">
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
            v-if="created && userData.id !== otherUser.id"
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
  </div>
</template>
<script>
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import { mapMutations, mapGetters } from 'vuex'
export default {
  components: {
    ErrorCard
  },
  data () {
    return {
      isFollowed: false,
      created: "",
      userNotFound: false,
    }
  },
  async asyncData({ $axios, params, store, redirect }) {
    try {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      const data = await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      store.commit('modules/otherUser/setUser', data)
      return {
        userNotFound: false
      }
    } catch (error) {
      if (error.response.status === 404 ) {
        return {
          userNotFound: true
        }
      }
    }

  },
  async mounted() {
    this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/isFollowed', {
      params: {
        user_id: this.userData.id,
        follow_id: this.otherUser.id
      }
    })
      .then((res) => {
        this.isFollowed = Boolean(res)
        this.created = true
      })
      .catch((error) => {
        console.log('ユーザーが存在しません。')
      })
  },

  computed: {
    ...mapGetters({
      otherUser: 'modules/otherUser/otherUser',
      userData: 'modules/user/userData',
      following: 'modules/otherUser/following',
      followers: 'modules/otherUser/followers'
    }),
  },
  methods: {
    follow() {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
        user_id: this.$store.state.modules.user.userData.id,
        follow_id: this.$store.state.modules.otherUser.otherUser.id
      })
        .then(() => {
          this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/isFollowed', {
            params: {
              user_id: this.$store.state.modules.user.userData.id,
              follow_id: this.$store.state.modules.otherUser.otherUser.id
            }
          })
        .then((res) => {
          this.isFollowed = Boolean(res)
        })
          console.log("フォローに成功")
        })
        .then(() => {
          this.followers.push(Object)
        })
        .catch(() => {
          console.log("フォローに失敗")
        })
    },
    unfollow() {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/relationships/delete', {
        params: {
          user_id: this.$store.state.modules.user.userData.id,
          follow_id: this.$store.state.modules.otherUser.otherUser.id
        }
      })
        .then(() => {
          this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/isFollowed', {
            params: {
              user_id: this.$store.state.modules.user.userData.id,
              follow_id: this.$store.state.modules.otherUser.otherUser.id
            }
          })
        .then((res) => {
          this.isFollowed = Boolean(res)
        })
          console.log("フォロー解除に成功")
        })
        .then(() => {
          this.followers.splice(0, 1)
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