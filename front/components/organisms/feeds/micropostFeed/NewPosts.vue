<template>
  <v-container>
    <CreatePostDialog
      :dialog="createPostDialog"
      @createPost="createPost"
      @closeDialog="createPostDialog = false"
    />
    <v-row>
      <v-col cols="12" v-if="loading">
        <v-skeleton-loader
          class="mx-auto"
          type="card"
          v-for="n in 5"
          :key="n.id"
        />
      </v-col>
      <v-col cols="12" v-if="loading === false">
        <v-row>
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
            <VueInfiniteLoading
              ref="infiniteLoading"
              spinner="spiral"
              @infinite="infiniteHandler"
            >
              <span slot="no-more">-----投稿は以上です-----</span>
              <span slot="no-results"></span>
            </VueInfiniteLoading>
          </v-col>
        </v-row>
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
      count: 1
    }
  },
  props: {
    load: null
  },
  watch: {
    async load () {
      this.loading = true
      this.count = 1
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts?page=${this.count}`)
        .then(res => {
          this.setPosts(res)
          setTimeout(this.stopLoading, 500)
        })
    }
  },
  async mounted () {
    this.count = 1
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts?page=${this.count}`)
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
      reloadPostsByCreatePost: 'modules/post/reloadPostsByCreatePost',
      reloadPostsByPageScrolling: 'modules/post/reloadPostsByPageScrolling'
    }),
    stopLoading () {
      this.loading = false
    },
    openCreatePostDialog () {
      this.createPostDialog = true
    },
    createPost (payload) {
      this.reloadPostsByCreatePost(payload)
    },
    async infiniteHandler () {
      this.count += 1
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/posts?page=${this.count}`)
        .then(res => {
          if (res.length !== 0) {
            setTimeout(() => {
              this.reloadPostsByPageScrolling(res)
              this.$refs.infiniteLoading.stateChanger.loaded()
            }, 1000)
          } else {
            this.$refs.infiniteLoading.stateChanger.complete()
          }
        })
    }
  }
}
</script>