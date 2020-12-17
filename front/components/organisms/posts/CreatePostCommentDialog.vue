<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
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
          コメントする
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-icon
          dark
          @click="closeDialog"
        >
          mdi-close
        </v-icon>
      </v-toolbar>
      <v-card-text v-if="dialogStatus">
        <v-form>
          <ValidationObserver v-slot="ObserverProps">
            <ImagesForm
              @setImages="setImages"
            />
            <TextAreaWithValidation
              v-model="description"
              label="コメント内容"
              rules="max:255|required"
            />
            <v-row justify="center">
              <v-btn
                color="success"
                class="white--text"
                @click="createComment"
                :disabled="ObserverProps.invalid"
              >送信
              </v-btn>
            </v-row>
          </ValidationObserver>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import { mapActions } from 'vuex'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
export default {
  components: {
    TextAreaWithValidation,
    ImagesForm
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
      description: '',
      images: []
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
    async createComment () {
      const data = new FormData()
      const config = {
        headders: {
          'content-type': 'multipart/form-data'
        }
      }
      this.images.forEach(image => {
        data.append('comment[images][]', image)
      })
      data.append('comment[description]', this.description)
      data.append('comment[post_id]', this.postId)
      data.append('comment[reply_comment_id]', '')
      data.append('comment[user_id]', this.$store.state.modules.user.data.id)

      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/comments', data, config)
        .then(res => {
          console.log('投稿に成功しました')
          this.$emit('createPostComment', res)
          this.$emit('closeDialog')
          this.description = ''
          this.setFlash({
            status: true,
            message: "コメント作成に成功しました"
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ""
            })
          }, 2000)
        })
        .catch((error) => {
          console.log('投稿に失敗しました')
          console.log('error')
        })
    },
    closeDialog () {
      this.$emit('closeDialog')
      this.description = ''
    },
    setImages (payload) {
      this.images = payload
    }
  }
}
</script>
<style>
</style>