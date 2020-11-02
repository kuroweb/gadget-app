
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
        :to="`/users/${userId}`"
        text
        color="white"
        :outlined="true"
        small
      >
      マイページ
      </v-btn>
      <v-btn
        v-if="isAuthenticated"
        to="/"
        text
        color="white"
        :outlined="true"
        small
        @click="logOut"
      >
      ログアウト
      </v-btn>
    </div>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
  export default {
    computed: {
      ...mapGetters('modules/user', [
        'isAuthenticated',
        'userId'
      ])
    },
    methods: {
      ...mapActions('modules/user', [ 'logout', 'setFLASH' ]),
      async logOut () {
        await this.logout()
        this.$router.push('/')
        this.setFLASH({
          status: true,
          message: "ログアウトしました"
        })
        setTimeout(() => {
          this.setFLASH({
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