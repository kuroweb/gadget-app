<template>
  <v-card flat>
    <v-card-title>
      ユーザー検索
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="user"
        hint="ユーザー名を入力して検索"
      >
        <v-icon slot="prepend">mdi-magnify</v-icon>
      </v-text-field>
    </v-card-text>
    <v-card-text>
      <v-card
        class="mx-auto ma-5 pa-5"
        v-for="user in users"
        :key="user.id"
      >
        <v-card-title>
          <v-spacer/>
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
          <v-spacer/>
          <v-card flat :to="`/users/${user.id}`">
            <span>{{ user.name }}</span>
          </v-card>
          <v-spacer/>
        </v-card-title>
        <v-card-actions v-if="$store.state.modules.user.data.id !== user.id">
          <v-btn
            block
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
            block
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
        </v-card-actions>
      </v-card>
    </v-card-text>
  </v-card>
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
<style scoped>
</style>