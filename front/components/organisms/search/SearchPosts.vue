<template>
  <v-card-text>
    <v-text-field
      v-model="post"
      hint="投稿名を入力して検索"
    >
      <v-icon slot="prepend">mdi-magnify</v-icon>
    </v-text-field>
    <v-row
      v-for="post in post_result"
      :key="post.id"
    >
      <p>{{ post.description }}</p>
    </v-row>
  </v-card-text>
</template>
<script>
import _ from 'lodash'
export default {
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
<style>

</style>