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
        >変更
        </v-btn>
      </v-row>
      <p v-if="error" class="errors">{{error}}</p>
    </v-form>
  </ValidationObserver>
</v-card-text>