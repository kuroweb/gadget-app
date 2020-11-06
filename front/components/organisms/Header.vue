
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
        :to="`/users/edit`"
        text
        color="white"
        :outlined="true"
        small
      >
      編集
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
    <div class="text-center">
      <v-switch
        v-model="closeOnClick"
        label="Close on click"
      ></v-switch>
      <v-menu
        top
        :close-on-click="closeOnClick"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            color="primary"
            dark
            v-bind="attrs"
            v-on="on"
          >
            <img
            />
          </v-btn>
        </template>
        <v-list>
          <v-list-item
            v-for="(item, index) in items"
            :key="index"
          >
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </div>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data: () => ({
    items: [
      { title: 'Click Me' },
      { title: 'Click Me' },
      { title: 'Click Me' },
      { title: 'Click Me 2' },
    ],
    closeOnClick: true,
  }),
  computed: {
    ...mapGetters('modules/user', [
      'isAuthenticated',
      'userId',
      'userData'
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