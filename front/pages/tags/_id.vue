<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="投稿が存在しません。"
    />
    <v-card class="mx-auto" width="700px">
      <v-toolbar
        color="cyan darken-1"
        dark
        flat
      >
        <v-toolbar-title class="ml-3">
          {{ tag.tag_name }} の詳細ページ
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn
          v-if="tag.isFollowed === false"
          icon
          class="mr-1"
          @click="followTag"
        >
          <v-icon>mdi-heart-multiple</v-icon>
        </v-btn>
        <v-btn
          v-if="tag.isFollowed === true"
          icon
          class="mr-1"
          color="red"
          @click="unfollowTag"
        >
          <v-icon>mdi-heart-multiple</v-icon>
        </v-btn>
      </v-toolbar>
      <v-tabs
        fixed-tabs
        centered
        background-color="cyan darken-1"
        color="white"
        slider-color="orange"
      >
        <v-tab class="ma-0 pa-0">
          <v-icon>mdi-post</v-icon>
        </v-tab>
        <v-tab class="ma-0 pa-0">
          <v-icon>mdi-forum</v-icon>
        </v-tab>
        <v-tab class="ma-0 pa-0">
          <v-icon>mdi-account</v-icon>
        </v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-title>
              <Tag
                :tag="tag"
              />
              を含む投稿
            </v-card-title>
            <v-card-text>
              <SimplePostCard
                v-for="(post, index) in tag.posts"
                :key="index"
                :post="post"
              />
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-title>
              <Tag
                :tag="tag"
              />
              を含む掲示板
            </v-card-title>
            <v-card-text>
              <SimpleBoardCard
                v-for="(board, index) in tag.boards"
                :key="index"
                :board="board"
              />
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-title>
              <Tag
                :tag="tag"
              />
              をフォロー済みのユーザー
            </v-card-title>
            <v-card-text>
              <SimpleUserCard
                v-for="(user, index) in tag.users"
                :key="index"
                :user="user"
              />
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import Tag from '~/components/atoms/Tag.vue'
import SimplePostCard from '~/components/molecules/SimplePostCard.vue'
import SimpleBoardCard from '~/components/molecules/SimpleBoardCard.vue'
import SimpleUserCard from '~/components/molecules/SimpleUserCard.vue'
export default {
  components: {
    ErrorCard,
    Tag,
    SimplePostCard,
    SimpleBoardCard,
    SimpleUserCard
  },
  data () {
    return {
    }
  },
  async fetch ({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/tags/${params.id}`)
      .then(res => {
        store.dispatch('modules/tag/setData', res)
      })
      .catch(error => {
        console.log(error)
        console.log('エラー')
      })
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      error: 'modules/info/error',
      tag: 'modules/tag/data',
    })
  },
  methods: {
    ...mapActions({
      setIsFollowed: 'modules/tag/setIsFollowed'
    }),
    followTag () {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps', {
        follow_tag: {
          user_id: this.$store.state.modules.user.data.id,
          tag_id: this.tag.id
        }
      })
        .then(res => {
          this.setIsFollowed(res)
        })
    },
    unfollowTag () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps/delete', {
        params: {
          follow_tag: {
            user_id: this.$store.state.modules.user.data.id,
            tag_id: this.tag.id
          }
        }
      })
        .then(res => {
          this.setIsFollowed(res)
        })
    }
  }
}
</script>