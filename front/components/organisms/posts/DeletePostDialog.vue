<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
  >
    <v-card width="500px" class="mx-auto">
    <v-toolbar flat>
      <v-toolbar-title>投稿削除</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn 
        @click="closeDialog"
        icon
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </v-toolbar>
      <v-card-text>
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
            message: "投稿削除に成功しました"
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
<style>
</style>