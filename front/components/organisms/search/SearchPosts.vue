<template>
  <v-card flat>
    <v-card-title>
      投稿検索
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="post"
        hint="投稿名を入力して検索"
      >
        <v-icon slot="prepend">mdi-magnify</v-icon>
      </v-text-field>
    </v-card-text>
    <v-card-text>
      <v-card
        class="mx-auto ma-5 pa-5"
        v-for="post in post_result"
        :key="post.id"
      >
        <v-card-title>
          <v-spacer/>
          <v-avatar size="64">
            <img
              v-if="post.user.avatar_url"
              :src="post.user.avatar_url"
              alt="Avatar"
            />
            <img
              v-else
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            />
          </v-avatar>
          <v-spacer/>
          <v-card flat :to="`/users/${post.user.id}`">
            <span>{{ post.user.name }}</span>
          </v-card>
          <v-spacer/>
        </v-card-title>
        <v-card-text>
          <Tags
            :tags="post.tags"
          />
        </v-card-text>
        <v-card-text>
          <v-card flat :to="`/posts/${post.id}`">
            <span>{{ post.description }}</span>
          </v-card>
        </v-card-text>
        <v-card-text v-if="post.images_url">
          <Images
            :images="post.images_url"
          />
        </v-card-text>
      </v-card>
    </v-card-text>
  </v-card>
</template>
<script>
import _ from 'lodash'
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
import { mapGetters, mapActions } from 'vuex'
export default {
  components: {
    Tags,
    Images,
  },
  data () {
    return {
      post: '',
      post_result: []
    }
  },
  watch: {
    post () {
      this.delayFunc()
    }
  },
  methods: {
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/posts/search', {
        params: {
          post_name: this.post
        }
      })
        .then(res => {
          this.post_result = res
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  }
}
</script>
<style scoped>
</style>