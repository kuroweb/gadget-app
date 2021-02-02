<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
    persistent
    @click:outside="closeDialog"
  >
    <v-card class="mx-auto">
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          投稿を削除しますか？
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
        <v-container>
          <v-row>
            <v-col cols="12">
              <h3>この操作は取り消せません。投稿内容・投稿へのコメント・コメントに対する返信コメントが削除されます。</h3>
            </v-col>
            <v-col cols="12">
              <v-row justify="center">
                <v-btn
                  v-if="deletemode === 'admin' && $store.state.modules.user.data.email !== admin_email"
                  color="white--text grey"
                >削除（機能停止中）
                </v-btn>
                <v-btn
                  v-if="deletemode === 'admin' && $store.state.modules.user.data.email === admin_email"
                  color="white--text red"
                  @click="deletePost"
                >削除（管理者のみ）
                </v-btn>
                <v-btn
                  v-if="deletemode === 'owner'"
                  color="white--text red"
                  @click="deletePost"
                >削除
                </v-btn>
              </v-row>
            </v-col>
          </v-row>
        </v-container>
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
    postId: {
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
    async deletePost () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + `/v1/posts/${this.postId}`)
        .then(() => {
          this.$emit('deletePost', this.postId)
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