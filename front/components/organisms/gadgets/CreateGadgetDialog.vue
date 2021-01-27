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
          ガジェットを追加する
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
                <v-col cols="12" class="pa-0">
                  <ImagesForm
                    @setImages="setImages"
                  />
                </v-col>
                <v-col cols="12" class="pa-0">
                  <TextFieldWithValidation
                    v-model="title"
                    label="ガジェット名"
                    rules="max:64|required"
                  />
                </v-col>
                <v-col cols="12" class="pa-0">
                  <TextAreaWithValidation
                    v-model="good_description"
                    label="お気に入りポイント"
                    rules="max:255|required"
                  />
                </v-col>
                <v-col cols="12" class="pa-0">
                  <TextAreaWithValidation
                    v-model="bad_description"
                    label="気になるポイント"
                    rules="max:255|required"
                  />
                </v-col>
                <v-col cols="12" class="pa-0">
                  <span>満足度</span>
                  <v-row justify="center">
                    <v-rating
                      v-model="stars"
                      background-color="orange lighten-3"
                      color="orange"
                      large
                      length="5"
                      size="64"
                    ></v-rating>
                  </v-row>
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
                      @click="createGadget"
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
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
import TagsForm from '~/components/molecules/inputs/TagsForm.vue'
import GuestLogginButton from '~/components/organisms/GuestLogginButton.vue'
export default {
  components: {
    TextFieldWithValidation,
    TextAreaWithValidation,
    ImagesForm,
    TagsForm,
    GuestLogginButton
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
      title: '',
      good_description: '',
      bad_description: '',
      stars: 3,
      images: [],
      tag: '',
      tags: [],
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
    async createGadget () {
      const data = new FormData()
      const config = {
        headders: {
          'content-type': 'multipart/form-data'
        }
      }
      this.images.forEach(image => {
        data.append('gadget[images][]', image)
      })
      if (this.tags.length !== 0) {
        this.tags.forEach(tag => {
          data.append('gadget[tags][]', tag.text)
        })
      }
      data.append('gadget[title]', this.title)
      data.append('gadget[good_description]', this.good_description)
      data.append('gadget[bad_description]', this.bad_description)
      data.append('gadget[stars]', this.stars)
      data.append('gadget[user_id]', this.$store.state.modules.user.data.id)
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/gadgets', data, config)
        .then(res => {
          console.log('投稿に成功しました')
          this.$emit('createGadget', res)
          this.$emit('closeDialog')
          this.title = ''
          this.good_description = ''
          this.bad_description = ''
          this.stars = 3
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
      this.title = ''
      this.good_description = ''
      this.bad_description = ''
      this.stars = 3
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