<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
    persistent
  >
    <v-card>
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          ログインしてください
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-icon
          dark
          @click="closeDialog"
        >
          mdi-close
        </v-icon>
      </v-toolbar>
      <v-card-text>
        <v-col class="text-center" cols="12">
          <span>ログインが必要な機能です</span>
        </v-col>
        <v-col cols="12">
          <v-row justify="center">
            <v-btn
              color="orange"
              class="mx-auto white--text mt-4"
              @click="guestSignIn"
            >
              ゲストユーザーとしてログイン
            </v-btn>
          </v-row>
        </v-col>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import { mapActions } from 'vuex'
import firebaseApp from "@/plugins/firebase"
export default {
  components: {
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialogStatus: this.dialog
    }
  },
  watch: {
    dialog (newValue) {
      this.dialogStatus = newValue
    },
  },
  methods: {
    ...mapActions({
      guestLogin: "modules/user/guestLogin",
      setLoading: "modules/info/setLoading",
      setFlash: "modules/info/setFlash",
    }),
    closeDialog () {
      this.$emit('closeDialog')
    },
    async guestSignIn () {
      this.setLoading(true)
      setTimeout(() => {
        this.setLoading(false)
      }, 1000)
      this.guestLogin()
        .then(() => {
          this.setFlash({
            status: true,
            message: "ゲストユーザーとしてログインしました",
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: "",
            })
          }, 2000)
          this.closeDialog()
        })
    }
  }
}
</script>
<style scoped>
</style>