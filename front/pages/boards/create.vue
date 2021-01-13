<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2>掲示板を作成</h2>
      </v-card-title>
      <v-form>
        <ValidationObserver v-slot="ObserverProps">
          <ImagesForm
            @setImages="setImages"
          />
          <SelectFormWithValidation
            v-model="type"
            :items="items"
            label="掲示板タイプ"
            rules="required"
          />
          <TextFieldWithValidation
            v-model="title"
            label="タイトル"
            rules="max:255|required"
          />
          <TextAreaWithValidation
            v-model="description"
            label="説明文"
            rules="max:255|required"
          />
          <client-only>
            <VueTagsInput
              v-model="tag"
              :tags="tags"
              @tags-changed="newTags => tags = newTags"
            />
          </client-only>
          <v-row justify="center">
            <v-btn
              color="success"
              class="white--text"
              @click="createBoard"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
            >作成
            </v-btn>
          </v-row>
        </ValidationObserver>
      </v-form>
    </v-card>
  </v-container>
</template>
  
<script>
import { mapGetters } from 'vuex'
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import SelectFormWithValidation from '~/components/molecules/inputs/SelectFormWithValidation.vue'
import ImagesForm from '~/components/molecules/inputs/ImagesForm.vue'
export default {
  components: {
    TextFieldWithValidation,
    TextAreaWithValidation,
    SelectFormWithValidation,
    ImagesForm
  },
  data () {
    return {
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
  computed: {
    ...mapGetters({
      isAuthenticated: 'modules/user/isAuthenticated',
      currentUser: 'modules/user/data',
    }),
  },
  methods: {
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
      data.append('board[user_id]', this.currentUser.id)
      // this.tagsの中身を抽出して配列に格納
      if (this.tags.length !== 0) {
        this.tags.forEach(function(tag){
        data.append('board[tags][]', tag.text)
        })
      }
      this.$axios.$post(process.env.BROWSER_BASE_URL + `/v1/boards`, data, config)
        .then(() => {
          console.log('作成に成功しました')
        })
        .catch((error) => {
          console.log('作成に失敗しました')
          console.log(error)
        })
    },
    addImage (n) {
      const file = this.$data['image' + n]
      if (file !== undefined && file !== null) {
        if (file.size > 1000000) {
          console.log('ファイルサイズが大きすぎます')
          this.$data['image' + n] = []
          this.imageError = "画像のファイルサイズが1MBを超えています。"
        }
        if (file.size <= 1000000) {
          const fr = new FileReader()
          fr.readAsDataURL(file)
          fr.addEventListener('load', () => {
          this.$data['image' + n + 'Url'] = fr.result
          })
          this.imageError = null
        }
      } else {
        this.$data['image' + n + 'Url'] = []
        this.$data['image' + n] = []
        this.imageError = null
      }
    },
    removeImage (n) {
      this.$data['image' + n + 'Url'] = []
      this.$data['image' + n] = []
      this.imageError = null
    },
    setImages (payload) {
      this.images = payload
    }
  }
}
</script>
<style scoped>
.input-box {
  padding: 0 30%;
}
</style>