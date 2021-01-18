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
          投稿する
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
                    label="説明文"
                    rules="max:255|required"
                  />
                </v-col>
                <v-col cols="12">
                  <TagsForm
                    v-model="tag"
                    :initTags="tags"
                    @tags-changed="newTags => tags = newTags"
                  />
                </v-col>
                <v-col cols="12">
                  <v-row justify="center">
                    <v-btn
                      color="success"
                      class="white--text"
                      @click="createPost"
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
  </v-dialog>
</template>
<script>
import { mapActions } from 'vuex'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
import TagsForm from '~/components/molecules/inputs/TagsForm.vue'
export default {
  components: {
    TextAreaWithValidation,
    ImagesForm,
    TagsForm
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
  },
  data () {
    return {
      dialogStatus: this.dialog,
      description: '',
      images: [],
      tag: '',
      tags: []
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
    async createPost () {
      const data = new FormData()
      const config = {
        headders: {
          'content-type': 'multipart/form-data'
        }
      }
      this.images.forEach(image => {
        data.append('post[images][]', image)
      })
      if (this.tags.length !== 0) {
        this.tags.forEach(tag => {
          data.append('post[tags][]', tag.text)
        })
      }
      data.append('post[description]', this.description)
      data.append('post[user_id]', this.$store.state.modules.user.data.id)
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/posts', data, config)
        .then(res => {
          console.log('投稿に成功しました')
          this.$emit('createPost', res)
          this.$emit('closeDialog')
          this.description = ''
          this.tags = []
          this.setFlash({
            status: true,
            message: "投稿に成功しました"
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
      this.tags = []
    },
    setImages (payload) {
      this.images = payload
    }
  }
}
</script>
<style scoped>
</style>