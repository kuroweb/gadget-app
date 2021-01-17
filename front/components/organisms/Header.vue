<template>
  <v-app-bar
    color="cyan darken-2" 
    dark 
    app 
    fixed
  >
    <v-toolbar-title>
      <n-link to="/" style="color:white; text-decoration:none">
        <h2 class="app-title">ガジェコミ！</h2>
      </n-link>
    </v-toolbar-title>
    <v-spacer />
    <div class="header-list">
      <v-btn
        v-if="!isAuthenticated"
        to="/auth/signin"
        text
        color="white"
        :outlined="true"
        small
      >
      ログイン
      </v-btn>
      <v-btn
        v-if="!isAuthenticated"
        to="/auth/signup"
        text
        color="white"
        :outlined="true"
        small
      >
      新規登録
      </v-btn>
      <v-btn
        v-if="isAuthenticated"
        to="/search"
        icon
        text
        color="white"
        small
        class="mr-3"
      >
        <v-icon>
          mdi-magnify
        </v-icon>
      </v-btn>
    </div>
    <v-menu
      v-model="value"
      :offset-y="true"
      :left="true"
      v-if="currentUser"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-avatar
          size="30"
          v-bind="attrs"
          v-on="on"
        >
          <img
            v-if="currentUser.avatar_url"
            :src="currentUser.avatar_url"
          >
          <img
            v-else
            src="~/assets/images/default_icon.jpeg"
          />
        </v-avatar>
      </template>
      <v-list
        :dense="true"
        width="200px"
      >
        <v-list-item
          v-for="(item, index) in items"
          :key="index"
          :to="item.to"
        >
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
        <v-list-item
          @click="logOut"
        >
          ログアウト
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data () {
    return {
      value: false,
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'modules/user/isAuthenticated',
      currentUser: 'modules/user/data',
    }),
    items() {
      const items = [
        {
          title: 'マイページ',
          to: `/users/${this.currentUser.id}`
        },
        {
          title: '詳細設定',
          to: '/users/edit'
        },
      ]
      return items
    }
  },
  methods: {
    ...mapActions({
      logout: 'modules/user/logout',
      setFlash: 'modules/info/setFlash'
    }),
    async logOut() {
      this.logout()
      this.$router.push('/')
      this.setFlash({
        status: true,
        message: "ログアウトしました"
      })
      setTimeout(() => {
        this.setFlash({
          status: false,
          message: ""
        })
      }, 2000)

      // this.logout().then(() => {
      //   this.$router.push('/')
      // }).catch((error) => {
      //   console.log(error.message)
      // })
    }
  }
}
</script>
<style scoped>

</style>