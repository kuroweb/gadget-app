<template>
  <v-container>
    <CreatePostDialog
      :dialog="createPostDialog"
      @createPost="createPost"
      @closeDialog="createPostDialog = false"
    />
    <v-row v-if="loading">
      <v-col cols="12">
        <v-skeleton-loader
          class="mx-auto"
          type="card"
          v-for="n in 5"
          :key="n.id"
        />
      </v-col>
    </v-row>
    <v-row v-if="loading === false">
      <v-col cols="12">
        <v-btn
          block
          color="orange"
          dark
          rounded
          @click="openCreatePostDialog"
        >
          新しい投稿を追加する
        </v-btn>
      </v-col>
      <v-col cols="12">
        <MicroPostCard
          v-for="(post, index) in posts"
          :key="index"
          :post="post"
        />
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
import MicroPostCard from '~/components/organisms/MicroPostCard.vue'
import CreatePostDialog from '~/components/organisms/posts/CreatePostDialog.vue'
export default {
  components: {
    MicroPostCard,
    CreatePostDialog
  },
  data () {
    return {
      loading: true,
      createPostDialog: false,
    }
  },
  props: {
    load: null
  },
  watch: {
    async load () {
      this.loading = true
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts`)
        .then(res => {
          this.setPosts(res)
          setTimeout(this.stopLoading, 500)
        })
    }
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts`)
      .then(res => {
        this.setPosts(res)
        setTimeout(this.stopLoading, 500)
      })
  },
  computed: {
    ...mapGetters({
      posts: 'modules/post/posts'
    })
  },
  methods: {
    ...mapActions({
      setPosts: 'modules/post/setPosts',
      reloadPostsByCreatePost: 'modules/post/reloadPostsByCreatePost'
    }),
    stopLoading () {
      this.loading = false
    },
    openCreatePostDialog () {
      this.createPostDialog = true
    },
    createPost (payload) {
      this.reloadPostsByCreatePost(payload)
    }
  }
}
</script>