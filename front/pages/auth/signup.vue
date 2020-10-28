<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="signup-title">新規登録</h2>
    </v-card-title>
    <v-card-text>
    <ValidationObserver
      v-slot="{ invalid }"
    >
      <v-form>
        <p v-if="error" class="errors">{{error}}</p>
        <TextField
          v-model="name"
          label="名前"
          rules="max:20|required"
        />
        <TextField
          v-model="email"
          label="メールアドレス"
          rules="max:255|required|email"
        />
        <TextField
          v-model="password"
          label="パスワード"
          rules="required|min:6"
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
          vid="password"
        />
        <TextField
          v-model="passwordConfirm"
          label="パスワード(再入力)"
          rules="required|min:6|confirmed:パスワード"
          :type="show2 ? 'text' : 'password'"
          :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"
        />
        <v-row justify="center">
          <v-btn
            color="success"
            class="mx-auto white--text mt-4"
            :disabled="invalid"
            @click="signUp"
          >新規登録
          </v-btn>
        </v-row>
      </v-form>
    </ValidationObserver>
    </v-card-text>
  </v-card>
</template>


<script>
import { mapActions } from 'vuex'
import firebaseApp from '@/plugins/firebase'
import TextField from '~/components/atoms/TextField.vue'

export default {
  middleware: 'handle-login-route',
  components: {
    TextField,
  },
  data () {
    return {
      name: '',
      email: '',
      password: '',
      passwordConfirm: '',
      show1: false,
      show2: false,
      error: ''

    }
  },
  methods: {
    ...mapActions('modules/user', ['login', 'setLOADING', 'setFLASH']),
    async signUp () {
      this.setLOADING(true)
      try {
        // 要リファクタリング（新規登録、APIリクエスト、それぞれにエラーハンドリングが必要）
        const firebaseUser = await firebaseApp.auth().createUserWithEmailAndPassword(this.email, this.password)
        await this.login(firebaseUser.user)
        const user = await {
          name: this.name,
          email: firebaseUser.user.email,
          uid: firebaseUser.user.uid
        }
        this.$axios.$post(process.env.BROWSER_BASE_URL + "/v1/users", { user })
        this.setFLASH({
          status: true,
          message: "登録に成功しました"
        })
        await this.$router.push("/")
        setTimeout(() => {
          this.setFLASH({
            status: false,
            message: ""
          })
        }, 2000)
      } catch (error) {
        this.error = (code => {
          switch (code) {
            case "auth/email-already-in-use":
              return "既にそのメールアドレスは使われています";
            case "auth/wrong-password":
              return "※パスワードが正しくありません";
            case "auth/weak-password":
              return "※パスワードは最低6文字以上にしてください";
            default:
              return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
      }
      this.setLOADING(false)
    },
  }
}
</script>

<style>
  .signup-title {
    font-size: 24px;
  }

</style>

