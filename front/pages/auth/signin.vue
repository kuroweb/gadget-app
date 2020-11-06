<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="signup-title">ログイン</h2>
    </v-card-title>
    <v-card-text>
    <ValidationObserver
      v-slot="{ invalid }"
    >
      <v-form>
        <p v-if="error" class="errors">{{error}}</p>
        <TextFieldWithValidation
          v-model="email"
          label="メールアドレス"
          rules="max:255|required|email"
        />
        <TextFieldWithValidation
          v-model="password"
          label="パスワード"
          rules="required|min:6"
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
          vid="password"
        />
        <v-row justify="center">
          <v-btn
            color="success"
            class="mx-auto white--text mt-4"
            :disabled="invalid"
            @click="signIn"
          >ログイン
          </v-btn>
        </v-row>
      </v-form>
    </ValidationObserver>
    </v-card-text>
  </v-card>
</template>

<script>
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
import { mapActions } from 'vuex'
import firebaseApp from "@/plugins/firebase"

export default {
  components: {
    TextFieldWithValidation,
  },
  data () {
    return {
      email: '',
      password: '',
      show1: false,
      error: ''

    }
  },
  middleware: ['handle-login-route'],
  methods: {
    ...mapActions('modules/user', ['login', 'setLOADING', 'setFLASH']),
    async signIn () {
      this.setLOADING(true)
      firebaseApp.auth().signInWithEmailAndPassword(this.email, this.password)
        .then((res) => {
          this.login(res.user)
        })
        .then(() => {
          this.setFLASH({
            status: true,
            message: "ログインしました"
          })
          this.setLOADING(false)
          setTimeout(() => {
            this.setFLASH({
              status: false,
              message: ""
            })
          }, 2000)
          this.$router.push("/")
        })
        .catch((error) => {
          this.error = (code => {
          switch (code) {
            case "auth/user-not-found":
              return "メールアドレスが間違っています";
            case "auth/wrong-password":
              return "※パスワードが正しくありません";
            default:
              return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        })
    }
  }
}
</script>


<style scoped>
  form {
    padding: 16px;
  }

  input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
  }

  button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
  }

  button:hover {
    opacity: 0.8;
  }

  .container {
    padding: 16px;
    max-width: 400px;
  }

</style>
