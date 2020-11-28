<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2 class="create-post-h2">投稿編集</h2>
      </v-card-title>
      <v-form>
        <ValidationObserver v-slot="ObserverProps">
          <div class="create-post-box">
            <v-row>
              <v-col cols=3 sm=3 md=3 lg=3 xl=3
                align-self="center"
                v-for="n in maxImageNum"
                :key="n.id"
              >
                <v-row justify="center">
                  <v-avatar
                    justify="center"
                    v-if="$data['image' + n].length != 0"
                    size="62"
                  >
                    <img
                      v-if="$data['image' + n + 'Url']"
                      :src="$data['image' + n + 'Url']"
                    />
                  </v-avatar>
                </v-row>
                <v-row justify="center">
                  <v-btn
                    v-if="$data['image' + n].length != 0"
                    color="success"
                    @click="removeImage(n)"
                  >
                    削除
                  </v-btn>
                </v-row>
                <div class="input-box">
                  <v-file-input
                    v-if="$data['image' + n].length == 0"
                    accept="image/*"
                    v-model="$data['image' + n]"
                    @change="addImage(n)"
                    prepend-icon="mdi-camera"
                    label="File input"
                    hide-input
                  />
                </div>
              </v-col>
              <p v-if="imageError">{{ imageError }}</p>
            </v-row>
            <TextFieldWithValidation
              v-model="description"
              label="説明文"
              rules="max:80|required"
            />
            <v-row justify="center">
              <v-btn
                color="success"
                class="white--text"
                @click="updatePost"
                :disabled="ObserverProps.invalid"
              >更新
              </v-btn>
            </v-row>
            <v-row justify="center">
              <v-btn
                color="white--text red"
                @click="deletePost"
              >削除
              </v-btn>
            </v-row>
          </div>
        </ValidationObserver>
      </v-form>
    </v-card>
  </v-container>
</template>
  
<script>
import { mapGetters } from 'vuex'
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
export default {
  components: {
    TextFieldWithValidation,
  },
  data () {
    return {

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
      test: []
    }
  },
  async asyncData({ $axios, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const res = await $axios.$get(baseUrl + `/v1/posts/2`)
    return {
      description: res.description,
      images_url: res.images_url
    }
  },
  async mounted() {
    // forEach文だと順番にばらつきが発生。冗長な記述ながら問題解消。
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

    if (this.images_url !== null) {
      let i = 1
      this.images_url.forEach(image_url => {
        this.$data['image' + i + 'Url'] = image_url
        i += 1
      })
    }

  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'modules/user/isAuthenticated',
      currentUser: 'modules/user/data',
    }),
  },
  methods: {
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
      this.$axios.$patch(process.env.BROWSER_BASE_URL + `/v1/posts/2`, data, config)
      .then(() => {
        console.log('投稿に成功しました')
      })
      .catch((error) => {
        console.log('投稿に失敗しました')
        console.log(error)
      })
    },
    async deletePost () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + `/v1/posts/2`)
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
    }
  }
}
</script>
<style>
.input-box {
  padding: 0 30%;
}

.create-post-h2 {
  font-size: 24px;
}
</style>