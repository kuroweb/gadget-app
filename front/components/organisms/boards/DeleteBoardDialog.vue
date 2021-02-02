<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
    @click:outside="closeDialog"
  >
    <v-card width="500px" class="mx-auto">
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          掲示板を削除する
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
        <v-row class="mt-5 mb-5" justify="center">
          <h3>本当に掲示板を削除しますか？</h3>
        </v-row>
        <v-row justify="center">
          <v-btn
            v-if="deletemode === 'admin' && $store.state.modules.user.data.email !== admin_email"
            color="white--text grey"
          >削除（機能停止中）
          </v-btn>
          <v-btn
            v-if="deletemode === 'admin' && $store.state.modules.user.data.email === admin_email"
            color="white--text red"
            @click="deleteBoard"
          >削除（管理者のみ）
          </v-btn>
          <v-btn
            v-if="deletemode === 'owner'"
            color="white--text red"
            @click="deleteBoard"
          >削除
          </v-btn>
        </v-row>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import { mapActions } from 'vuex'
export default {
  components: {
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
    boardId: {
      type: null,
    },
    deletemode: {
      type: String
    }
  },
  data () {
    return {
      dialogStatus: this.dialog,
      admin_email: process.env.ADMIN_EMAIL
    }
  },
  watch: {
    dialog (newValue) {
      this.dialogStatus = newValue
    },
  },
  computed: {
  },
  methods: {
    ...mapActions({
      setFlash: 'modules/info/setFlash'
    }),
    async deleteBoard () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + `/v1/boards/${this.boardId}`)
        .then(() => {
          this.$emit('deleteBoard', this.boardId)
          this.$emit('closeDialog')
          this.setFlash({
            status: true,
            message: "削除に成功しました"
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            })
          }, 2000)
        })
    },
    closeDialog () {
      this.$emit('closeDialog')
    },
  }
}
</script>
<style scoped>
</style>