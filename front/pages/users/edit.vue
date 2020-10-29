<template>
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
            <ValidationObserver
              v-slot="{ invalid }"
            >
              <v-form>
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
                  color="light-blue lighten-3"
                  class="mx-auto white--text mt-4"
                  :disabled="invalid"
                  @click="changeAccount"
                  >変更
                  </v-btn>
                </v-row>
                <p v-if="error" class="errors">{{error}}</p>
              </v-form>
            </ValidationObserver>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card flat>
          <v-card-text>
            <p>プロフィール編集ページをここに作成</p>
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs>
  </v-card>
</template>
  
<script>
import TextField from '~/components/atoms/TextField.vue'
import firebase from "@/plugins/firebase";
export default {
  middleware: 'authenticated',
  components: {
    TextField
  },
  data() {
    return {
      email: '',
      name: '',
      password: '',
      passwordConfirm: '',
      show1: false,
      show2: false,
      error: ''
    }
  },
  computed: {

  },
  async asyncData({ $axios, store }) {
    const uid = store.getters['modules/user/uid']
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const data = await $axios.$get(baseUrl + `/v1/users?uid=${uid}`)
    return {
      email: data.email,
      name: data.name,
    }
  },

  methods: {
    async changeAccount() {
      
    }
  }
}
</script>
  
<style>
  .user-edit-title {
    font-size: 24px;
  }
</style>