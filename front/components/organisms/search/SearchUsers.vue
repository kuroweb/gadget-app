<template>
  <v-card-text>
    <v-text-field
      v-model="user"
      hint="ユーザー名を入力して検索"
    >
      <v-icon slot="prepend">mdi-magnify</v-icon>
    </v-text-field>
    <v-card
      class="mx-auto mt-3 pa-3"
      v-for="(user, index) in users"
      :key="index"
    >
      <v-row>
        <v-col sm="4" md="4" lg="4" cols="4">
          <v-row justify="center">
            <v-avatar size="64">
              <img
                v-if="user.avatar_url"
                :src="user.avatar_url"
                alt="Avatar"
              />
              <img
                v-else
                src="~/assets/images/default_icon.jpeg"
                alt="Avatar"
              />
            </v-avatar>
          </v-row>
        </v-col>
        <v-col sm="4" md="4" lg="4" cols="4" align-self="center">
          <v-row justify="center">
            <v-card flat :to="`/users/${user.id}`">
              <h3>{{ user.name }}</h3>
            </v-card>
          </v-row>
        </v-col>
        <v-col sm="4" md="4" lg="4" align-self="center">
          <v-row justify="center">
            <v-btn
              v-if="user.isFollowed === false"
              @click="followUser(user)"
              class="success"
            >
              <v-icon>
                mdi-account
              </v-icon>
              フォローする
            </v-btn>
            <v-btn
              v-if="user.isFollowed === true"
              @click="unFollowUser(user)"
              class="white--text"
              color="red"
            >
              <v-icon>
                mdi-account
              </v-icon>
              フォロー解除
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
    </v-card>
  </v-card-text>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import _ from 'lodash'
export default {
  mounted () {
    this.resetUsers()
  },
  data () {
    return {
      user: ''
    }
  },
  watch: {
    user () {
      this.delayFunc()
    }
  },
  computed: {
    ...mapGetters({
      users: 'modules/otherUser/users'
    })
  },
  methods: {
    ...mapActions({
      setUsers: 'modules/otherUser/setUsers',
      reloadUsersByFollow: 'modules/otherUser/reloadUsersByFollow',
      reloadUsersByUnFollow: 'modules/otherUser/reloadUsersByUnFollow',
      resetUsers: 'modules/otherUser/resetUsers'
    }),
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/users/search', {
        params: {
          user_name: this.user
        }
      })
        .then(res => {
          this.setUsers(res)
        })
        .catch(error => {
          console.log(error)
        })
    },
    followUser (user) {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
        user_id: this.$store.state.modules.user.data.id,
        follow_id: user.id
      })
        .then(() => {
          this.reloadUsersByFollow(user)
        })
    },
    unFollowUser (user) {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/relationships/delete', {
        params: {
          user_id: this.$store.state.modules.user.data.id,
          follow_id: user.id
        }
      })
        .then(() => {
          this.reloadUsersByUnFollow(user)
        })
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  }
}
</script>
<style>

</style>