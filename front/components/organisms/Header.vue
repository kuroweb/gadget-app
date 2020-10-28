
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
      ])
    },
    methods: {
      ...mapActions('modules/user', [ 'logout' ]),
      async logOut () {
        await this.logout()
        this.$router.push('/')

        // this.logout().then(() => {
        //   this.$router.push('/')
        // }).catch((error) => {
        //   console.log(error.message)
        // })
      }
    }
  }
</script>