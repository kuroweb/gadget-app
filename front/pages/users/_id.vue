<template>
  <v-container>
    <PostEditDialog
      :dialog="editDialog"
      :postId="postId"
      @closeDialog="editDialog = false"
    />
    <PostDeleteDialog
      :dialog="deleteDialog"
      :postId="postId"
      @closeDialog="deleteDialog = false"
    />
    <ErrorCard
      :display="!otherUser.id"
      title="404NotFound"
      message="ユーザーが存在しません。"
    />
    <v-card v-if="otherUser.id" class="mx-auto mt-5 pa-5" width="500px">
      <v-card-text>
        <v-row justify="center">
          <v-avatar 
          size="62"
          >
            <img 
              v-if="otherUser.avatar_url"
              :src="otherUser.avatar_url"
              alt="Avatar"
            >
            <img
              v-else
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            >
          </v-avatar>
        </v-row>
        <v-row justify="center">
          <h3>{{ otherUser.name }} さん</h3>
        </v-row>
        <v-row justify="center">
          <p>{{ otherUser.profile }}</p>
        </v-row>
        <v-row justify="center">
          <v-col>
            <p>フォロー</p>
            <p>{{ following.length }}人</p>
          </v-col>
          <v-col>
            <p>フォロワー</p>
            <p>{{ followers.length }}人</p>
          </v-col>
        </v-row>
        <v-row justify="center">
          <div
            v-if="isAuthenticated && currentUser.id !== otherUser.id"
          >
            <v-btn
              v-if="!isFollowed"
              color="success"
              @click="follow"
            >
              フォローする
            </v-btn>
            <v-btn
              v-else
              color="white--text red"
              @click="unfollow"
            >
              フォロー解除
            </v-btn>
          </div>
        </v-row>
      </v-card-text>
    </v-card>
    <v-card
      v-for="post in sortById()"
      :key="post.id"
      class="mx-auto mt-5 pa-5" width="500px"
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
            <p
              v-for="tag in post.tags"
              :key="tag.id"
            >
              {{ tag.tag_name }}
            </p>
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
        <v-row justify="end">
          <v-icon
            @click="openEditDialog(post)"
          >
            mdi-square-edit-outline
          </v-icon>
          <v-icon
            @click="openDeleteDialog(post)"
          >
            mdi-delete
          </v-icon>
        </v-row>
      </v-card-text>
    </v-card>
  </v-container>
</template>
<script>
import _ from 'lodash'
import PostDeleteDialog from '~/components/organisms/posts/PostDeleteDialog.vue'
import PostEditDialog from '~/components/organisms/posts/PostEditDialog.vue'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    ErrorCard,
    PostEditDialog,
    PostDeleteDialog
  },
  data () {
    return {
      isFollowed: false,
      editDialog: false,
      deleteDialog: false,
      postId: '',
    }
  },
  async fetch({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      .then(res => {
        // アクセス先ユーザーの基本情報をコミット
        const data = {
          id: res.user.id,
          name: res.user.name,
          profile: res.user.profile,
          avatar_url: res.user.avatar_url,
        }
        store.commit('modules/otherUser/setData', data)
        // アクセス先ユーザーのフォロー・フォロワー情報をコミット
        store.commit('modules/otherUser/setFollowing', res.user.following)
        store.commit('modules/otherUser/setFollowers', res.user.followers)
        // アクセス先ユーザーの投稿情報をコミット
        store.commit('modules/otherUser/setPosts', res.posts)
      })
      .catch(error => {
        console.log(error)
      })
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/users/isFollowed', {
      params: {
        current_user: this.$store.state.modules.user.data.id,
        other_user: this.$store.state.modules.otherUser.data.id
      }
    })
      .then(res => {
        this.isFollowed = res
      })
      .catch(error => {
        console.log(error)
      })
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      otherUser: 'modules/otherUser/data',
      following: 'modules/otherUser/following',
      followers: 'modules/otherUser/followers',
      posts: 'modules/otherUser/posts'
    })
  },
  methods: {
    ...mapActions('modules/otherUser', ['setFollowers']),
    follow() {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/relationships', {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
      })
        .then(res => {
          this.isFollowed = true
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then(res => {
          this.setFollowers (res)
          console.log('フォローに成功')
        })
        .catch(() => {
          console.log("フォローに失敗")
        })
    },
    unfollow() {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/relationships/delete', {
        params: {
          user_id: this.currentUser.id,
          follow_id: this.otherUser.id
        }
      })
        .then(res => {
          this.isFollowed = false
          return this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/users/${this.$route.params.id}/followers`)
        })
        .then(res => {
          this.setFollowers (res)
          console.log('フォロー解除に成功')
        })
        .catch(() => {
          console.log("フォロー解除に失敗")
        })
    },
    openEditDialog (post) {
      this.postId = post.id
      this.editDialog = true
    },
    openDeleteDialog (post) {
      this.postId = post.id
      this.deleteDialog = true
    },
    // 一時的にフロント側でソートしてるだけ。後々バックエンド側で日付順ソートを実装する。
    sortById () {
      return _.orderBy(this.posts, 'id', 'desc')
    }
  }

}
</script>
<style>

</style>