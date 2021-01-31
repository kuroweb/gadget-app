<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
    persistent
    @click:outside="closeDialog"
  >
    <v-card>
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          コメントを削除しますか？
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
              <h3>この操作は取り消せません。コメント内容・コメントに対する返信コメントが削除されます。</h3>
            </v-col>
            <v-col cols="12">
              <v-row justify="center">
                <v-btn
                  v-if="deletemode === 'admin'"
                  color="white--text grey"
                >削除（機能停止中）
                </v-btn>
                <v-btn
                  v-if="deletemode === 'owner'"
                  color="white--text red"
                  @click="deleteComment"
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
    comment: {
      type: null
    },
    deletemode: {
      type: String
    }
  },
  data () {
    return {
      dialogStatus: this.dialog,
    }
  },
  watch: {
    dialog (newValue) {
      this.dialogStatus = newValue
    },
  },
  methods: {
    ...mapActions({
      setFlash: 'modules/info/setFlash'
    }),
    async deleteComment () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/post_comments/delete', {
        params: {
          comment_id: this.comment.id,
          reply_comment_id: this.comment.reply_comment_id
        }
      })
        .then(() => {
          this.$emit('deletePostComment', this.comment)
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