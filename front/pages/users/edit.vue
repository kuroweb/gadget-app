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
                    <h3>メールアドレスを変更</h3>
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
                    <h3>パスワードを変更</h3>
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
                <ValidationObserver>
                  <div class="user-avatar-box">
                    <h3>アバター画像</h3>
                    <FileInput
                      v-model="avatar"
                      label="画像"
                      rules="size:1000"
                    />
                  </div>
                </ValidationObserver>
                <ValidationObserver
                  v-slot="{ invalid }"
                >
                  <div class="profile-box">
                    <h3>アカウント名</h3>
                    <TextField
                      v-model="name"
                      label="名前"
                      rules="max:30|required"
                    />
                    <h3>プロフィール文</h3>
                    <TextArea
                      v-model="profile"
                      label="プロフィール"
                      rules="max:300"
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
              <v-form>
                <div class="delete-box">
                  <h3>アカウントを削除</h3>
                  <form>
                    <v-row justify="center">
                      <v-btn
                        block
                        color="white--text red"
                        @click="openDialogForDeleteAccount"
                      >削除
                      </v-btn>
                    </v-row>
                  </form>
                </div>
              </v-form>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </v-container>
</template>
  
<script>
import FileInput from '~/components/atoms/FileInput.vue'
import TextArea from '~/components/atoms/TextArea.vue'
import LoginDialog from '~/components/organisms/LoginDialog.vue'
import { mapActions, mapGetters } from 'vuex'
import TextField from '~/components/atoms/TextField.vue'
import firebaseApp from "@/plugins/firebase";
export default {
  middleware: 'authenticated',
  components: {
    TextField,
    LoginDialog,
    TextArea,
    FileInput
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
      profile: '',
      isDeleteAccount: false,
      avatar: '',
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
      profile: data.profile
    }
  },
  computed: {
    ...mapGetters('modules/user', [
      'uid',
    ])
  },
  methods: {
    ...mapActions('modules/user', ['setLOADING', 'setFLASH', 'logout']),
    loginSuccess() {
      if(this.isEmail) {
        this.isEmail = false
        this.changeEmail()
      }
      else if(this.isPassword) {
        this.isPassword = false
        this.changePassword()
      }
      else if(this.isDeleteAccount) {
        this.isDeleteAccount = false
        this.destroyUserAccount()
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
    openDialogForDeleteAccount() {
      this.isDeleteAccount = true
      this.dialog = true
    },
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
    async changeUserName() {
      this.$axios.$patch(`/v1/users/${this.userId}`, {
        user: {
          name: this.name,
          profile: this.profile
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
    },
    async destroyUserAccount() {
      const user = await firebaseApp.auth().currentUser
      user.delete()
        .then(() => {
          this.$axios.$delete(process.env.BROWSER_BASE_URL + `/v1/users/${this.userId}`)
        })
          .then(() => {
            this.logout()
            this.setFLASH({
              status: true,
              message: "ユーザーを削除しました"
            })
            setTimeout(() => {
              this.setFLASH({
                status: false,
                message: ""
              })
            }, 2000)
            this.$router.push("/")
          })
    }
  }
}
</script>
  
<style>
  .user-edit-title {
    font-size: 24px;
  }
  .password-box {
    margin-top: 24px;
    padding-top: 16px;
  }
  .delete-box {
    margin-top: 24px;
    padding-top: 16px;
  }
</style>