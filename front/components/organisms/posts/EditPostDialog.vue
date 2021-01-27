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
          投稿を編集する
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
                  <v-container>
                    <v-row>
                      <v-col cols=3
                        align-self="center"
                        v-for="n in maxImageNum"
                        :key="n.id"
                      >
                        <v-row>
                          <v-col cols="12" v-if="$data['image' + n].length != 0">
                            <v-row justify="center">
                              <v-avatar
                                justify="center"
                                size="62"
                              >
                                <img
                                  v-if="$data['image' + n + 'Url']"
                                  :src="$data['image' + n + 'Url']"
                                />
                              </v-avatar>
                            </v-row>
                          </v-col>
                          <v-col cols="12" v-if="$data['image' + n].length != 0">
                            <v-row justify="center">
                              <v-btn
                                color="red"
                                class="white--text"
                                @click="removeImage(n)"
                              >
                                削除
                              </v-btn>
                            </v-row>
                          </v-col>
                          <v-col cols="12" v-if="$data['image' + n].length == 0">
                            <div class="input-box">
                              <v-file-input
                                accept="image/*"
                                v-model="$data['image' + n]"
                                @change="addImage(n)"
                                prepend-icon="mdi-camera"
                                hide-input
                              />
                            </div>
                          </v-col>
                        </v-row>
                      </v-col>
                    </v-row>
                  </v-container>
                  <p v-if="imageError" class="red--text">{{ imageError }}</p>
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
                      @click="updatePost"
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
import { mapGetters, mapActions } from 'vuex'
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
import TagsForm from '~/components/molecules/inputs/TagsForm.vue'
export default {
  components: {
    TextAreaWithValidation,
    TagsForm
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
      maxImageNum: 4,
      image1Url: [],
      image2Url: [],
      image3Url: [],
      image4Url: [],
      image1: [],
      image2: [],
      image3: [],
      image4: [],
      imageError: null,
      images_url: [],
      description: '',
      tag: '',
      tags: []
    }
  },
  watch: {
    async dialog (newValue) {
      // モーダルウィンドウを表示
      this.dialogStatus = newValue
      // モーダルウィンドウ内に必要なデータの初期化
      if (this.dialogStatus === true) {
        const res = await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts/${this.postId}`)
        this.description = res.description
        this.images_url = res.images_url
        // tagの初期化
        if (res.tags.length !== 0) {
          const tagsData = []
          res.tags.forEach(tag => {
            const tagData = {
              text: tag.tag_name,
              tiClasses: ["ti-valid"]
            }
            tagsData.push(tagData)
          })
          this.tags = tagsData
        }
        // プレビュー画像の初期化
        if (this.images_url !== null) {
          let i = 1
          this.images_url.forEach(image_url => {
            this.$data['image' + i + 'Url'] = image_url
            i += 1
          })
        }
        // 画像データの初期化
        if (this.images_url !== null) {
          if (this.images_url.length === 1) {
            fetch(`${this.images_url[0]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image1.jpg')
                this.image1 = file
              })
          }
          if (this.images_url.length === 2) {
            fetch(`${this.images_url[0]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image1.jpg')
                this.image1 = file
              })
            fetch(`${this.images_url[1]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image2.jpg')
                this.image2 = file
              })
          }
          if (this.images_url.length === 3) {
            fetch(`${this.images_url[0]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image1.jpg')
                this.image1 = file
              })
            fetch(`${this.images_url[1]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image2.jpg')
                this.image2 = file
              })
            fetch(`${this.images_url[2]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image3.jpg')
                this.image3 = file
              })
          }
          if (this.images_url.length === 4) {
            fetch(`${this.images_url[0]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image1.jpg')
                this.image1 = file
              })
            fetch(`${this.images_url[1]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image2.jpg')
                this.image2 = file
              })
            fetch(`${this.images_url[2]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image3.jpg')
                this.image3 = file
              })
            fetch(`${this.images_url[3]}`)
              .then(res => {
                return res.blob()
              })
              .then(res => {
                const file = new File([res], 'image3.jpg')
                this.image4 = file
              })
          }
        }
      }
    },
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
    }),
  },
  methods: {
    ...mapActions({
      setFlash: 'modules/info/setFlash'
    }),
    async updatePost () {
      const data = new FormData()
      const config = {
        headders: {
          'content-type': 'multipart/form-data'
        }
      }
      if (this.image1.length !== 0) {
        data.append('post[images][]', this.image1)
      }
      if (this.image2.length !== 0) {
        data.append('post[images][]', this.image2)
      }
      if (this.image3.length !== 0) {
        data.append('post[images][]', this.image3)
      }
      if (this.image4.length !== 0) {
        data.append('post[images][]', this.image4)
      }
      data.append('post[description]', this.description)
      data.append('post[user_id]', this.currentUser.id)
      if (this.tags.length !== 0) {
        this.tags.forEach(function(tag){
        data.append('post[tags][]', tag.text)
        })
      }
      this.$axios.$patch(process.env.BROWSER_BASE_URL + `/v1/posts/${this.postId}`, data, config)
        .then(res => {
          console.log('編集に成功しました')
          this.$emit('editPost', res)
          this.$emit('closeDialog')
          this.resetData ()
          this.setFlash({
            status: true,
            message: '投稿を更新しました'
          })
          setTimeout(() => {
            this.setFlash({
              status: false,
              message: ''
            })
          }, 2000)
        })
        .catch((error) => {
          console.log('編集に失敗しました')
          console.log(error)
        })
    },
    closeDialog () {
      this.$emit('closeDialog')
      this.resetData ()
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
    resetData () {
      this.image1Url = []
      this.image2Url = []
      this.image3Url = []
      this.image4Url = []
      this.image1 = []
      this.image2 = []
      this.image3 = []
      this.image4 = []
      this.description = ''
      this.tags = []
    }
  }
}
</script>
<style scoped>
.input-box {
  padding: 0 30%;
}
</style>