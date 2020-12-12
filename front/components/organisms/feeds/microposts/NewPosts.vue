<template>
  <v-container>
    <div v-if="loading">
      <v-skeleton-loader
        class="mx-auto"
        type="card"
        v-for="n in 5"
        :key="n.id"
      />
    </div>
    <v-card
      flat
      v-if="loading === false"
    >
      <PostCard
        v-for="post in posts"
        :key="post.id"
        :post="post"
      />
    </v-card>
  </v-container>
</template>
<script>
import PostCard from '~/components/molecules/PostCard.vue'
export default {
  components: {
    PostCard,
  },
  data () {
    return {
      loading: true,
      posts: []
    }
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts`)
      .then(res => {
        setTimeout(this.stopLoading, 1000)
        return res
      })
      .then(res => {
        this.posts = res
      })
  },
  methods: {
    stopLoading () {
      this.loading = false
    }
  }
}
</script>