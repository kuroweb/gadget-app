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
import { mapActions, mapGetters } from 'vuex'
import PostCard from '~/components/molecules/PostCard.vue'
export default {
  components: {
    PostCard,
  },
  data () {
    return {
      loading: true,
    }
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts`)
      .then(res => {
        this.setPosts(res)
        setTimeout(this.stopLoading, 1000)
      })
  },
  computed: {
    ...mapGetters({
      posts: 'modules/post/posts'
    })
  },
  methods: {
    ...mapActions({
      setPosts: 'modules/post/setPosts'
    }),
    stopLoading () {
      this.loading = false
    }
  }
}
</script>