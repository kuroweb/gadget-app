<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="create-post-h2">新規投稿</h2>
    </v-card-title>
    <v-form>
      <ValidationObserver v-slot="ObserverProps">
        <div class="create-post-box">
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
</template>
  
<script>
import { mapGetters } from 'vuex'
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
export default {
  components: {
    TextFieldWithValidation
  },
  data () {
    return {
      title: '',
      description: ''
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
        user_id: this.userData.id
      })
      .then(() => {
        console.log('投稿に成功しました')
      })
      .catch((error) => {
        console.log('投稿に失敗しました')
        console.log(error)
      })
    }
  }
}
</script>
  
<style>
  .create-post-h2 {
    font-size: 24px;
  }
</style>