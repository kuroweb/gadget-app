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
          掲示板を作成する
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
                  <SelectFormWithValidation
                    v-model="type"
                    :items="items"
                    label="掲示板タイプ"
                    rules="required"
                  />
                </v-col>
                <v-col cols="12">
                  <TextFieldWithValidation
                    v-model="title"
                    label="タイトル"
                    rules="max:255|required"
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
                      @click="createBoard"
                      :disabled="ObserverProps.invalid || !ObserverProps.validated"
                    >作成
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
import SelectFormWithValidation from '~/components/molecules/inputs/SelectFormWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
import TagsForm from '~/components/molecules/inputs/TagsForm.vue'
import GuestLogginButton from '~/components/organisms/GuestLogginButton.vue'
export default {
  components: {
    TextFieldWithValidation,
    TextAreaWithValidation,
    SelectFormWithValidation,
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
      description: '',
      tag: '',
      tags: [],
      items: ['雑談',　'質問'],
      value: '',
      type: '',
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
    async createBoard () {
      const data = new FormData()
      const config = {
        headders: {
          'content-type': 'multipart/form-data'
        }
      }
      this.images.forEach(image => {
        data.append('board[images][]', image)
      })
      data.append('board[board_type]]', this.type)
      data.append('board[title]', this.title)
      data.append('board[description]', this.description)
      data.append('board[user_id]', this.$store.state.modules.user.data.id)
      // this.tagsの中身を抽出して配列に格納
      if (this.tags.length !== 0) {
        this.tags.forEach(tag => {
        data.append('board[tags][]', tag.text)
        })
      }
      this.$axios.$post(process.env.BROWSER_BASE_URL + `/v1/boards`, data, config)
        .then(res => {
          console.log('作成に成功しました')
          this.$emit('createBoard', res)
          this.$emit('closeDialog')
          this.type = ''
          this.title = ''
          this.description = ''
          this.tags = []
          this.setFlash({
            status: true,
            message: '作成に成功しました'
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ''
            })
          })
        })
        .catch((error) => {
          console.log('作成に失敗しました')
          console.log(error)
        })
    },
    closeDialog () {
      this.$emit('closeDialog')
      this.type = ''
      this.title = ''
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