<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
    persistent
  >
    <v-card
      class="mx-auto"
      v-if="$store.state.modules.user.data"
    >
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          コメントに返信
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-icon
          dark
          @click="closeDialog"
        >
          mdi-close
        </v-icon>
      </v-toolbar>
      <v-form>
        <v-card-text v-if="dialogStatus">
          <v-container>
            <ValidationObserver v-slot="ObserverProps">
              <v-row>
                <v-col cols="12">
                  <ImagesForm
                    @setImages="setImages"
                  />
                </v-col>
                <v-col cols="12">
                  <TextAreaWithValidation
                    v-model="description"
                    label="コメント内容"
                    rules="max:255|required"
                  />
                </v-col>
                <v-col col="12">
                  <v-row justify="center">
                    <v-btn
                      color="success"
                      class="white--text"
                      @click="createComment"
                      :disabled="ObserverProps.invalid"
                    >送信
                    </v-btn>
                  </v-row>
                </v-col>
              </v-row>
            </ValidationObserver>
          </v-container>
        </v-card-text>
      </v-form>
    </v-card>
    <v-card v-else>
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
            <GuestLogginButton/>
          </v-row>
        </v-col>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import { mapActions } from 'vuex'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
import GuestLogginButton from '~/components/organisms/GuestLogginButton.vue'
export default {
  components: {
    TextAreaWithValidation,
    ImagesForm,
    GuestLogginButton
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
    postId: {
      type: null,
    },
    parentComment: {
      type: null
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
        data.append('post_comment[images][]', image)
      })
      data.append('post_comment[description]', this.description)
      data.append('post_comment[post_id]', this.postId)
      data.append('post_comment[reply_comment_id]', this.parentComment.id)
      data.append('post_comment[user_id]', this.$store.state.modules.user.data.id)

      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/post_comments', data, config)
        .then(res => {
          console.log('投稿に成功しました')
          this.$emit('createPostReply', res)
          this.$emit('closeDialog')
          this.description = ''
          this.setFlash({
            status: true,
            message: "返信に成功しました"
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
<style scoped>
</style>