<template>
  <v-card-text>
    <v-text-field
      v-model="post"
      hint="投稿名を入力して検索"
    >
      <v-icon slot="prepend">mdi-magnify</v-icon>
    </v-text-field>
    <SimplePostCard
      v-for="(post, index) in post_result"
      :key="index"
      :post="post"
    />
  </v-card-text>
</template>
<script>
import _ from 'lodash'
import SimplePostCard from '~/components/molecules/SimplePostCard.vue'
export default {
  components: {
    SimplePostCard
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