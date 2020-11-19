<template>
  <v-container>
    <ErrorCard
      :display="!post"
      title="404NotFount"
      message="投稿が存在しません。"
    >
    </ErrorCard>
    <v-card
      v-if="post"
      class="mx-auto mt-5 pa-5" width="700px"
    >
      <v-card-title>
        <v-row>
          <v-col>
            <v-avatar 
              size="62"
            >
              <img 
                v-if="post.user.avatar_url"
                :src="post.user.avatar_url"
                alt="Avatar"
              >
              <img
                v-else
                src="~/assets/images/default_icon.jpeg"
                alt="Avatar"
              >
            </v-avatar>
          </v-col>
          <v-col>
            <h3>{{ post.user.name }}</h3>
          </v-col>
        </v-row>
      </v-card-title>
      <v-card-text>
        <v-row>
          <p>{{ post.description }}</p>
        </v-row>
        <v-row
          justify="center"
          v-if="post.images_url !== null"
        >
          <v-avatar v-if="post.images_url.length > 0">
            <img :src="post.images_url[0]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 1">
            <img :src="post.images_url[1]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 2">
            <img :src="post.images_url[2]">
          </v-avatar>
          <v-avatar v-if="post.images_url.length > 3">
            <img :src="post.images_url[3]">
          </v-avatar>
        </v-row>

      </v-card-text>
    </v-card>
  </v-container>
</template>
<script>
import { mapGetters } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
export default {
  components: {
    ErrorCard
  },
  data () {
    return {
      imageCount: null
    }
  },
  async fetch({ $axios, params, store }) {
    try {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      const data = await $axios.$get(baseUrl + `/v1/posts/${params.id}`)
      store.commit('modules/post/setPost', data)
    } catch (error) {
      console.log('投稿が存在しません。')
    }
  },
  computed: {
    ...mapGetters({
      post: 'modules/post/post'
    }),
  }
}
</script>
<style>

</style>