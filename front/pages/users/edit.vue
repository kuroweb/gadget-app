<template>
  <v-container>
    <LoginDialog
      :dialog="dialog"
      :email="emailOriginal"
      @loginSuccess="loginSuccess"
      @closeDialog="dialog = false"
    />
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-tabs
        centered
      >
        <v-tabs-slider></v-tabs-slider>
        <v-tab>アカウント</v-tab>
        <v-tab>プロフィール</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-form>
                <ValidationObserver
                  v-slot="{ invalid }"
                >
                  <div class="email-box">
                    <TextField
                      v-model="email"
                      label="メールアドレス"
                      rules="max:255|required|email"
                    />
                    <v-row justify="center">
                      <v-btn
                        color="success"
                        block
                        class="white--text"
                        :disabled="invalid"
                        @click="openDialogForEmail"
                      >変更
                      </v-btn>
                    </v-row>
                  </div>
                </ValidationObserver>
                <ValidationObserver
                  v-slot="{ invalid }"
                >
                  <div class="password-box">
                    <TextField
                      v-model="password"
                      label="変更後のパスワード"
                      rules="required|min:6"
                      :type="show1 ? 'text' : 'password'"
                      :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                      @click:append="show1 = !show1"
                      vid="password"
                    />
                    <TextField
                      v-model="passwordConfirm"
                      label="変更後のパスワード(再入力)"
                      rules="required|min:6|confirmed:変更後のパスワード"
                      :type="show2 ? 'text' : 'password'"
                      :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                      @click:append="show2 = !show2"
                    />  
                    <v-row justify="center">
                      <v-btn
                        color="success"
                        block
                        class="white--text"
                        :disabled="invalid"
                        @click="openDialogForPassword"
                      >変更
                      </v-btn>
                    </v-row>
                  </div>
                </ValidationObserver>
                <p v-if="error" class="errors">{{error}}</p>
              </v-form>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-form>
                <ValidationObserver
                  v-slot="{ invalid }"
                >
                  <div class="username-box">
                    <TextField
                      v-model="name"
                      label="名前"
                      rules="max:30|required"
                    />
                    <v-row justify="center">
                      <v-btn
                        color="success"
                        block
                        class="white--text"
                        :disabled="invalid"
                        @click="changeUserName"
                      >変更
                      </v-btn>
                    </v-row>
                  </div>
                </ValidationObserver>
                <p v-if="error" class="errors">{{error}}</p>
              </v-form>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </v-container>
</template>
  
<script>
import LoginDialog from '~/components/organisms/LoginDialog.vue'
import { mapActions, mapGetters } from 'vuex'
import TextField from '~/components/atoms/TextField.vue'
import firebaseApp from "@/plugins/firebase";
export default {
  middleware: 'authenticated',
  components: {
    TextField,
    LoginDialog
  },
  data() {
    return {
      email: '',
      emailOriginal: '',
      name: '',
      password: '',
      passwordConfirm: '',
      show1: false,
      show2: false,
      error: '',
      dialog: false,
      userId: '',
      isEmail: false,
      isPassword: false,
    }
  },
  async asyncData({ $axios, store }) {
    const uid = store.getters['modules/user/uid']
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const data = await $axios.$get(baseUrl + `/v1/users?uid=${uid}`)
    return {
      email: data.email,
      emailOriginal: data.email,
      name: data.name,
      userId: data.id,
    }
  },
  computed: {
    ...mapGetters('modules/user', [
      'uid',
    ])
  },
  methods: {
    ...mapActions('modules/user', ['setLOADING', 'setFLASH']),
    async changeEmail() {
      const user = await firebaseApp.auth().currentUser
      user.updateEmail(this.email)
        .then(() => {
          this.$axios.$patch(process.env.BROWSER_BASE_URL + `/v1/users/${this.userId}`, { user: { email: this.email }})
            .then((res) => {
              this.emailOriginal = res.email
              this.setFLASH({
                status: true,
                message: 'メールアドレスを変更しました'
              })
              setTimeout(() => {
                this.setFLASH({
                  status: false,
                  message: ""
                })
              }, 2000)
            })
        })
    },
    async changePassword() {
      const user = await firebaseApp.auth().currentUser
      user.updatePassword(this.password)
        .then(() => {
          //this.password = ''
          //this.passwordConfirm = ''
          this.setFLASH({
            status: true,
            message: 'パスワードを変更しました'
          })
          setTimeout(() => {
            this.setFLASH({
              status: false,
              message: ""
            })
          }, 2000)
        })
    },
    loginSuccess() {
      if(this.isEmail) {
        this.isEmail = false
        this.changeEmail()
      }
      else if(this.isPassword) {
        this.isPassword = false
        this.changePassword()
      }
    },
    openDialogForEmail() {
      this.isEmail = true
      this.dialog = true
    },
    openDialogForPassword() {
      this.isPassword = true
      this.dialog = true
    },
    async changeUserName() {
      this.$axios.$patch(`/v1/users/${this.userId}`, {
        user: {
          name: this.name
        }
      })
        .then((res) => {
          this.name = res.name
          this.setFLASH({
            status: true,
            message: "名前を変更しました"
          })
          setTimeout(() => {
            this.setFLASH({
              status: false,
              message: ""
            })
          }, 2000)
        })
    }
  },
}
</script>
  
<style>
  .user-edit-title {
    font-size: 24px;
  }
</style>