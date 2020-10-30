<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
  >
    <v-card width="400px" class="mx-auto">
      <v-card-title>
        <h4 class="user-edit-title">再認証</h4>
      </v-card-title>
      <v-form>
        <p v-if="error" class="errors">{{error}}</p>
        <TextField
          v-model="password"
          label="パスワード"
          rules="required|min:6"
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
          vid="password"
        />
      </v-form>
      <v-btn @click="login">再認証</v-btn>
      <v-btn @click="closeDialog">閉じる</v-btn>
    </v-card>
  </v-dialog>
</template>
  
<script>
import TextField from '~/components/atoms/TextField.vue'
import firebaseApp from "@/plugins/firebase"
export default {
  components: {
    TextField,
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
    email: {
      type: String,
      required: true
    },
  },
  data () {
    return {
      password: '',
      show1: false,
      error: '',
      dialogStatus: this.dialog,
    }
  },
  watch: {
    dialog (newValue) {
      this.dialogStatus = newValue
    }
  },
  methods: {
    login() {
      firebaseApp.auth().signInWithEmailAndPassword(this.email, this.password)
        .then(() => {
          this.$emit('loginSuccess')
          this.$emit('closeDialog')
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              default:
                return "※パスワードをご確認ください";
            }
          })(error.code);
        });
    },
    closeDialog () {
      this.$emit('closeDialog')
    }
  }
}
</script>
  
<style>
    
</style>