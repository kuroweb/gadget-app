<!-- このスパゲッティコードはイケマセン。要修正。 -->
<template>
  <v-container>
    <LoginDialog
      :dialog="dialog"
      :email="emailOriginal"
      @loginSuccess="loginSuccess"
      @closeDialog="dialog = false"
    />
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card class="mx-auto">
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="cyan darken-1"
            color="white"
            slider-color="orange"
            icons-and-text
          >
            <v-tab class="ma-0 pa-0">
              プロフィール
              <v-icon>mdi-account</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              登録情報
              <v-icon>mdi-account-cog</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items
            v-model="tab"
            touchless
          >
            <v-tab-item>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12">
                      <v-form>
                        <ValidationObserver>
                          <div class="user-avatar-box">
                            <EditAvatarForm
                              v-model="avatar"
                              label="アイコン画像"
                              icon="mdi-account-edit"
                              rules="size:5000"
                              :avatar_url="avatar_url"
                            />
                            <v-row justify="center">
                              <v-btn
                                block
                                color="success"
                                class="white--text"
                                @click="changeUserAvatar"
                              >
                                変更
                              </v-btn>
                            </v-row>
                          </div>
                        </ValidationObserver>
                        <ValidationObserver
                          v-slot="{ invalid }"
                        >
                          <div class="profile-box">
                            <EditTextField
                              v-model="name"
                              label="名前"
                              icon="mdi-account-edit"
                              rules="max:20|required"
                            />
                            <EditTextArea
                              v-model="profile"
                              label="プロフィール"
                              icon="mdi-account-details"
                              rules="max:255"
                            />
                            <v-row justify="center">
                              <v-btn
                                color="success"
                                block
                                class="white--text"
                                :disabled="invalid"
                                @click="changeUserProfile"
                              >
                                変更
                              </v-btn>
                            </v-row>
                          </div>
                        </ValidationObserver>
                        <p v-if="error" class="errors">{{error}}</p>
                      </v-form>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
            </v-tab-item>
            <v-tab-item>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12">
                      <v-form>
                        <ValidationObserver
                          v-slot="{ invalid }"
                        >
                          <div class="email-box">
                            <EditTextField
                              v-model="email"
                              label="メールアドレス"
                              icon="mdi-account-edit"
                              rules="max:255|required|email"
                            />
                            <v-row justify="center">
                              <v-btn
                                v-if="guest === false"
                                color="success"
                                block
                                class="white--text"
                                :disabled="invalid"
                                @click="openDialogForEmail"
                              >
                                変更
                              </v-btn>
                              <v-btn
                                v-else
                                color="grey"
                                block
                                class="white--text"
                                :disabled="invalid"
                              >
                                変更（ゲストユーザーのため変更不可）
                              </v-btn>
                            </v-row>
                          </div>
                        </ValidationObserver>
                      </v-form>
                    </v-col>
                    <v-col cols="12">
                      <ValidationObserver
                        v-slot="{ invalid }"
                      >
                        <div class="password-box">
                          <h3>パスワードを変更する</h3>
                          <TextFieldWithValidation
                            v-model="password"
                            label="変更後のパスワード"
                            rules="required|min:6"
                            :type="show1 ? 'text' : 'password'"
                            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                            @click:append="show1 = !show1"
                            vid="password"
                          />
                          <TextFieldWithValidation
                            v-model="passwordConfirm"
                            label="変更後のパスワード(再入力)"
                            rules="required|min:6|confirmed:変更後のパスワード"
                            :type="show2 ? 'text' : 'password'"
                            :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                            @click:append="show2 = !show2"
                          />  
                          <v-row justify="center">
                            <v-btn
                              v-if="guest === false"
                              color="success"
                              block
                              class="white--text"
                              :disabled="invalid"
                              @click="openDialogForPassword"
                            >
                              変更
                            </v-btn>
                            <v-btn
                              v-else
                              color="grey"
                              block
                              class="white--text"
                              :disabled="invalid"
                            >
                              変更（ゲストユーザーのため変更不可）
                            </v-btn>
                          </v-row>
                        </div>
                      </ValidationObserver>
                      <p v-if="error" class="errors">{{error}}</p>
                    </v-col>
                    <v-col cols="12">
                      <h3>アカウントを削除する</h3>
                    </v-col>
                    <v-col cols="12">
                      <v-row justify="center">
                        <v-btn
                          v-if="guest === false"
                          block
                          color="white--text red"
                          @click="openDialogForDeleteAccount"
                        >
                          削除
                        </v-btn>
                        <v-btn
                          v-else
                          block
                          color="white--text grey"
                        >
                          変更（ゲストユーザーのため変更不可）
                        </v-btn>
                      </v-row>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>

  </v-container>
</template>
  
<script>
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
import EditAvatarForm from '~/components/organisms/users/EditAvatarForm.vue'
import EditTextArea from '~/components/organisms/users/EditTextArea.vue'
import EditTextField from '~/components/organisms/users/EditTextField.vue'
import LoginDialog from '~/components/organisms/users/LoginDialog.vue'
import { mapActions, mapGetters } from 'vuex'
import firebaseApp from "@/plugins/firebase";
export default {
  middleware: 'authenticated',
  components: {
    LoginDialog,
    EditTextField,
    EditTextArea,
    EditAvatarForm
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
      avatar: [],
      tab: null,
      guest: false
    }
  },
  async asyncData({ $axios, store }) {
    const currentUser = store.getters['modules/user/data']
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const res = await $axios.$get(baseUrl + `/v1/users/${currentUser.id}`)
    return {
      email: res.email,
      emailOriginal: res.email,
      name: res.name,
      userId: res.id,
      profile: res.profile,
      avatar_url: res.avatar_url,
      guest: res.guest
    }
  },

  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
    })
  },

  methods: {
    ...mapActions({
      login: 'modules/user/login',
      logout: 'modules/user/logout',
      setLoading: 'modules/info/setLoading',
      setFlash: 'modules/info/setFlash'
    }),
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
          this.$axios.$patch(process.env.BROWSER_BASE_URL + `/v1/users/${this.userId}`, { user: { email: this.email,
                                                                                                  uid: this.$store.state.modules.user.user.uid}})
            .then((res) => {
              this.emailOriginal = res.email
              this.setFlash({
                status: true,
                message: 'メールアドレスを変更しました'
              })
              setTimeout(() => {
                this.setFlash({
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
          this.setFlash({
            status: true,
            message: 'パスワードを変更しました'
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            })
          }, 2000)
        })
    },
    async changeUserProfile() {
      this.$axios.$patch(process.env.BROWSER_BASE_URL +　`/v1/users/${this.userId}`, {
        user: {
          name: this.name,
          profile: this.profile,
          uid: this.$store.state.modules.user.user.uid
        }
      })
        .then((res) => {
          this.name = res.name
          this.setFlash({
            status: true,
            message: "プロフィールを変更しました"
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            })
          }, 2000)
        })
    },
    async changeUserAvatar() {
      const formData = new FormData()
      formData.append('avatar', this.avatar)
      formData.append('uid', this.$store.state.modules.user.user.uid)
      formData.append('id', this.$store.state.modules.user.data.id)
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      this.$axios.$patch(process.env.BROWSER_BASE_URL + `/v1/users/${this.userId}/update_avatar`, formData, config)
        .then((res) => {
          this.avatar = res.avatar
          this.setFlash({
            status: true,
            message: "画像を変更しました"
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            })
          }, 2000)
        })
        .catch((error) => {
          this.setFlash({
            status: true,
            message: "画像の更新に失敗しました。"
          })
          setTimeout(() => {
            this.setFlash({
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
          this.$axios.$delete(process.env.BROWSER_BASE_URL + `/v1/users/${this.userId}`, {
            params: {
              uid: this.$store.state.modules.user.user.uid
            }
          })
        })
          .then(() => {
            this.logout()
            this.setFlash({
              status: true,
              message: "ユーザーを削除しました"
            })
            setTimeout(() => {
              this.setFlash({
                status: false,
                message: ""
              })
            }, 2000)
            this.$router.push("/")
          })
    },
  }
}
</script>
  
<style scoped>
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
  .profile-box {
    margin-top: 24px;
    padding-top: 16px;
  }
</style>