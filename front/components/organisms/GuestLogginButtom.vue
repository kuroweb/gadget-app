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
      login: "modules/user/login",
      setLoading: "modules/info/setLoading",
      setFlash: "modules/info/setFlash",
    }),
    async guestSignIn () {
      this.setLoading(true)
      firebaseApp
        .auth()
        .signInWithEmailAndPassword(process.env.GUEST_EMAIL, process.env.GUEST_PASSWORD)
        .then(res => {
          this.login(res.user)
        })
        .then(() => {
          this.setFlash({
            status: true,
            message: "ゲストユーザーとしてログインしました"
          })
          this.setLoading(false)
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            }, 2000)
          })
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case "auth/user-not-found":
                return "メールアドレスが間違っています"
              case "auth/wrong-password":
                return "※パスワードが正しくありません"
              default:
                return "※メールアドレスとパスワードをご確認ください"
            }
          })(error.code)
          this.setLoading(false)
        })
    }
  }
}
</script>