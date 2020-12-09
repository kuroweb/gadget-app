<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2>掲示板を作成</h2>
      </v-card-title>
      <v-form>
        <ValidationObserver v-slot="ObserverProps">
          <div class="create-board-box">
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
      description: '',
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
      tag: '',
      tags: []
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
      if (this.image1.length !== 0) {
        data.append('board[images][]', this.image1)
      }
      if (this.image2.length !== 0) {
        data.append('board[images][]', this.image2)
      }
      if (this.image3.length !== 0) {
        data.append('board[images][]', this.image3)
      }
      if (this.image4.length !== 0) {
        data.append('board[images][]', this.image4)
      }
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
    }
  }
}
</script>
<style>
.input-box {
  padding: 0 30%;
}

.create-board-h2 {
  font-size: 24px;
}
</style>