<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
  >
    <v-card width="500px" class="mx-auto">
    <v-toolbar flat>
      <v-toolbar-title>再認証</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn 
        @click="closeDialog"
        icon
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </v-toolbar>
      <v-card-text>
        <v-form>
          <p v-if="error" class="errors">{{error}}</p>
          <ValidationObserver
            v-slot="{ invalid }"
          >
            <TextFieldWithValidation
              v-model="password"
              label="現在のパスワード"
              rules="required|min:6"
              :type="show1 ? 'text' : 'password'"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"
              vid="password"
            />
            <v-card-actions>
              <v-row
                justify="center"
              >
                <v-btn
                  color="success"
                  block
                  :disabled="invalid"
                  @click="login"
                >再認証
                </v-btn>
              </v-row>
            </v-card-actions>
          </ValidationObserver>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
  
<script>
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
import firebaseApp from "@/plugins/firebase"
export default {
  components: {
    TextFieldWithValidation,
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
          this.password = ''
          this.error = ''
          this.$emit('closeDialog')
        })
        .catch(error => {
          this.password = ''
          this.error = ''
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
  
<style scoped>
    
</style>