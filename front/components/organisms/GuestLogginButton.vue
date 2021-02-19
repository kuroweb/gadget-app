<template>
  <v-btn
    color="orange"
    class="mx-auto white--text mt-4"
    @click="guestSignIn"
  >
    ゲストユーザーとしてログイン
  </v-btn>
</template>
<script>
import { mapActions } from 'vuex'
import firebaseApp from "@/plugins/firebase"
export default {
  methods: {
    ...mapActions({
      guestLogin: "modules/user/guestLogin",
      setLoading: "modules/info/setLoading",
      setFlash: "modules/info/setFlash",
    }),
    async guestSignIn () {
      this.setLoading(true)
      setTimeout(() => {
        this.setLoading(false)
        this.guestLogin()
          .then(() => {
            this.setFlash({
              status: true,
              message: "ゲストユーザーとしてログインしました",
            })
            setTimeout(() => {
              this.setFlash({
                status: false,
                message: "",
              })
            }, 2000)
          })
      }, 1000)
    }
  }
}
</script>