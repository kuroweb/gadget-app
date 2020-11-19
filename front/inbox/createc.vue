<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2 class="create-post-h2">新規投稿</h2>
      </v-card-title>
      <v-form>
        <ValidationObserver v-slot="ObserverProps">
          <div class="create-post-box">
            <v-row>
              <v-col cols=3 sm=3 md=3 lg=3 xl=3
                align-self="center"
                v-for="image in maxImageNum"
                :key="image.id"
              >
                <v-row justify="center">
                  <v-avatar
                    v-if="image.file"
                    size="62"
                  >
                    <img
                      :src="image.file"
                    />
                  </v-avatar>
                </v-row>
                <v-row justify="center">
                  <v-btn
                    v-if="image.file"
                    color="success"
                  >
                    削除
                  </v-btn>
                </v-row>
              </v-col>
              <v-col cols=3 sm=3 md=3 lg=3 xl=3
                align-self="center"
                v-for="n in maxImageNum - imageList.length"
                :key="n.id"
              >
                <input
                  :id="n"
                  type="file"
                  accept="image/*"
                  @change="addImage(n, $event)"
                >
              </v-col>
            </v-row>
            <TextFieldWithValidation
              v-model="title"
              label="タイトル"
              rules="max:80|required"
            />
            <TextFieldWithValidation
              v-model="description"
              label="説明文"
              rules="max:80|required"
            />
            <v-row justify="center">
              <v-btn
                color="success"
                class="white--text"
                @click="createPost"
                :disabled="ObserverProps.invalid || !ObserverProps.validated"
              >投稿
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
      title: '',
      description: '',
      maxImageNum: 4,
      imageList: []
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'modules/user/isAuthenticated',
      userData: 'modules/user/userData',
    }),
  },
  methods: {
    async createPost () {
      
      this.$axios.$post(process.env.BROWSER_BASE_URL + `/v1/posts`, {
        title: this.title,
        description: this.description,
        user_id: this.userData.id,
        images: this.images
      })
      .then(() => {
        console.log('投稿に成功しました')
      })
      .catch((error) => {
        console.log('投稿に失敗しました')
        console.log(error)
      })
    },
    addImage (id, e) {
      const file = e.target.file[0]
      const reader = new FileReader()
      reader.readAsDataURL(file)
      reader.onload = f => {
        this.imageList.push({file: f.target.result, type: file.type, name: file.name})
      }
      
    }
  }
}
</script>
<style>

.create-post-h2 {
  font-size: 24px;
}
</style>