<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
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
            color="white--text red"
            @click="deletePost"
          >削除
          </v-btn>
        </v-row>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
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
  computed: {
  },
  methods: {
    async deletePost () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/comments/delete', {
        params: {
          comment_id: this.comment.id,
          reply_comment_id: this.comment.reply_comment_id
        }
      })
        .then(() => {
          this.$emit('deletePostComment', this.comment)
          this.$emit('closeDialog')
        })
    },
    closeDialog () {
      this.$emit('closeDialog')
    },
  }
}
</script>
<style>
</style>