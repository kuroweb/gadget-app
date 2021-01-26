<template>
  <v-app-bar
    color="cyan darken-1" 
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
    <v-btn
      v-if="!isAuthenticated"
      to="/auth/signin"
      text
      color="white"
      :outlined="true"
      small
    >
      <span>ログイン</span>
    </v-btn>
    <v-btn
      v-if="!isAuthenticated"
      to="/auth/signup"
      text
      color="white"
      :outlined="true"
      small
    >
      <span>新規登録</span>
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
    <NoticeFeed v-if="currentUser"/>
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
          <v-list-item-title>ログアウト</v-list-item-title>
        </v-list-item>
        <v-divider/>
        <v-list-item>
          <v-switch
            v-model="admin"
            color="orange"
            inset
            @change="changeAdmin"
            :label="`God mode`"
          ></v-switch>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import NoticeFeed from '~/components/organisms/NoticeFeed.vue'
import Hint from '~/components/molecules/Hint.vue'
export default {
  componetns: {
    NoticeFeed,
    Hint
  },
  data () {
    return {
      value: false,
      admin: false
    }
  },
  mounted () {
    if (this.currentUser) {
      this.admin = this.currentUser.admin
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
      setFlash: 'modules/info/setFlash',
      setAdmin: 'modules/user/setAdmin'
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
    },
    changeAdmin () {
      this.setAdmin(this.admin)
    }
  }
}
</script>
<style scoped>

</style>