<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
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
          コメントを削除
        </v-toolbar-title>
        <v-spacer></v-spacer>
      <v-btn 
        @click="closeDialog"
        icon
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
      </v-toolbar>
      <v-card-text>
        <v-row class="mt-5 mb-5" justify="center">
          <h3>本当にコメントを削除しますか？</h3>
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
            @click="deleteComment"
          >削除（管理者のみ）
          </v-btn>
          <v-btn
            v-if="deletemode === 'owner'"
            color="white--text red"
            @click="deleteComment"
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
      admin_email: process.env.ADMIN_EMAIL
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
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/board_comments/delete', {
        params: {
          comment_id: this.comment.id,
          reply_comment_id: this.comment.reply_comment_id
        }
      })
        .then(() => {
          this.$emit('deleteCommentComment', this.comment)
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