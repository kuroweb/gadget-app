<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="投稿が存在しません。"
    />
    <CreatePostCommentDialog
      :dialog="createCommentDialog"
      :postId="postId"
      @createPostComment="createPostComment"
      @closeDialog="createCommentDialog = false"
    />
    <CreatePostReplyDialog
      :dialog="createReplyDialog"
      :postId="postId"
      :parentComment="parentComment"
      @createPostReply="createPostReply"
      @closeDialog="createReplyDialog = false"
    />
    <DeletePostCommentDialog
      :dialog="deleteCommentDialog"
      :postId="postId"
      :comment="comment"
      @deletePostComment="deletePostComment"
      @closeDialog="deleteCommentDialog = false"
    />
    <EditPostDialog
      :dialog="editPostDialog"
      :postId="postId"
      @editPost="editPost"
      @closeDialog="editPostDialog = false"
    />
    <DeletePostDialog
      :dialog="deletePostDialog"
      :postId="postId"
      @deletePost="deletePost"
      @closeDialog="deletePostDialog = false"
    />
    <v-row
      justify="center"
      v-if="error === false"
    >
      <v-col lg="3" sm="8" cols="12">
        <v-card>
          <p>関連投稿を表示</p>
        </v-card>
      </v-col>
      <v-col lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>{{ post.user.name }}さんの投稿</v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-card
              class="mx-auto pa-3"
              flat
            >
              <v-row justify="center">
                <v-col>
                  <v-avatar 
                  size="84"
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
                <v-col
                  align-self="center"
                >
                  <h3>{{ post.user.name }}</h3>
                </v-col>
              </v-row>
              <v-card
                flat
                :to="`/posts/${post.id}`"
              >
                <span>{{ post.description }}</span>
              </v-card>
              <Images
                :images="post.images_url"
              />
              <Tags
                :tags="post.tags"
              />
              <v-row>
                <v-col cols="8" align-self="center">
                  <span>{{ $moment(post.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
                </v-col>
                <v-col cols="4">
                  <v-row justify="end" class="pr-3">
                    <v-btn
                      icon
                      text
                    >
                      <v-icon>
                        mdi-comment-outline
                      </v-icon>
                    </v-btn>
                    <span>{{ post.commentCounts }}</span>
                    <v-btn
                      v-if="post.isLikedPost === true"
                      icon
                      text
                      color="red"
                      @click="disLikedPost(post)"
                    >
                      <v-icon>
                        mdi-heart
                      </v-icon>
                    </v-btn>
                    <v-btn
                      v-if="post.isLikedPost === false"
                      icon
                      text
                      color="grey darken-2"
                      @click="likedPost(post)"
                    >
                      <v-icon>
                        mdi-heart-outline
                      </v-icon>
                    </v-btn>
                    <span>{{ post.likedUsersCounts }}</span>
                  </v-row>
                </v-col>
              </v-row>
              <!-- 管理者メニュー -->
              <v-sheet
                color="grey lighten-2"
                rounded
                v-if="$store.state.modules.user.data && post.user.id === $store.state.modules.user.data.id"
              >
                <v-row dense>
                  <v-col cols="6" align-self="center">
                    <span class="ml-3">管理メニュー</span>
                  </v-col>
                  <v-col cols="6">
                    <v-row justify="end">
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openEditPostDialog"
                      >
                        <v-icon>
                          mdi-pencil-box-multiple
                        </v-icon>
                      </v-btn>
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openDeletePostDialog"
                        class="mr-3"
                      >
                        <v-icon>
                          mdi-delete
                        </v-icon>
                      </v-btn>
                    </v-row>
                  </v-col>
                </v-row>
              </v-sheet>
            </v-card>
            <v-row
              class="pa-3"
            >
              <v-btn
                block
                color="orange"
                dark
                rounded
                @click="openCreateCommentDialog"
              >
                コメントする
              </v-btn>
            </v-row>
            <div
              v-for="comment in post.comments"
              :key="comment.id"
            >
              <v-card
                class="mx-auto pa-3"
              >
                <v-row>
                  <v-col>
                    <v-avatar 
                      size="64"
                    >
                      <img 
                        v-if="comment.user.avatar_url"
                        :src="comment.user.avatar_url"
                        alt="Avatar"
                      >
                      <img
                        v-else
                        src="~/assets/images/default_icon.jpeg"
                        alt="Avatar"
                      >
                    </v-avatar>
                  </v-col>
                  <v-col align-self="center">
                    <h3>{{ comment.user.name }}</h3>
                  </v-col>
                </v-row>
                <span>{{ comment.description }}</span>
                <Images
                  :images="comment.images_url"
                />
                <v-row class="pr-3">
                  <v-col cols="9" align-self="center">
                    <span>{{ $moment(comment.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
                  </v-col>
                  <v-col cols="3">
                    <v-row justify="end">
                      <v-btn
                        rounded
                        color="success"
                        class="cyan darken-1"
                        @click="openCreateReplyDialog(comment)"
                      >
                        返信
                      </v-btn>
                    </v-row>
                  </v-col>
                </v-row>
                <!-- 管理者メニュー -->
                <v-sheet
                  color="grey lighten-2"
                  rounded
                  v-if="$store.state.modules.user.data && comment.user.id === $store.state.modules.user.data.id"
                >
                  <v-row dense>
                    <v-col cols="6" align-self="center">
                      <span class="ml-3">管理メニュー</span>
                    </v-col>
                    <v-col cols="6">
                      <v-row justify="end">
                        <v-btn
                          icon
                          text
                          color="grey darken-2"
                          @click="openDeleteCommentDialog(comment)"
                          class="mr-3"
                        >
                          <v-icon>
                            mdi-delete
                          </v-icon>
                        </v-btn>
                      </v-row>
                    </v-col>
                  </v-row>
                </v-sheet>
              </v-card>
              <v-timeline
                v-if="'childComments' in comment"
                align-top
              >
                <v-timeline-item
                  v-for="child in comment.childComments"
                  :key="child.id"
                  small
                  color="grey"
                  right
                  hide-dot
                >
                  <v-card
                    color="grey"
                  >
                    <v-card-title class="title white--text">
                      <v-icon dark>mdi-reply</v-icon>
                      返信コメント
                    </v-card-title>
                    <v-card-text class="white text--primary">
                      <v-row>
                        <v-col>
                          <v-avatar 
                            size="48"
                          >
                            <img 
                              v-if="child.user.avatar_url"
                              :src="child.user.avatar_url"
                              alt="Avatar"
                            >
                            <img
                              v-else
                              src="~/assets/images/default_icon.jpeg"
                              alt="Avatar"
                            >
                          </v-avatar>
                        </v-col>
                        <v-col align-self="center">
                          <h3>{{ child.user.name }}</h3>
                        </v-col>
                      </v-row>
                      <span>{{ child.description }}</span>
                      <Images
                        :images="child.images_url"
                      />
                      <v-row dense justify="start">
                        <span>{{ $moment(child.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
                      </v-row>
                      <!-- 管理者メニュー -->
                      <v-sheet
                        color="grey lighten-2"
                        rounded
                        v-if="$store.state.modules.user.data && child.user.id === $store.state.modules.user.data.id"
                      >
                        <v-row dense>
                          <v-col cols="6" align-self="center">
                            <span class="ml-3">管理メニュー</span>
                          </v-col>
                          <v-col cols="6">
                            <v-row justify="end">
                              <v-btn
                                icon
                                text
                                color="grey darken-2"
                                @click="openDeleteCommentDialog(child)"
                                class="mr-3"
                              >
                                <v-icon>
                                  mdi-delete
                                </v-icon>
                              </v-btn>
                            </v-row>
                          </v-col>
                        </v-row>
                      </v-sheet>
                    </v-card-text>
                  </v-card>
                </v-timeline-item>
              </v-timeline>
            </div>
          </v-container>
        </v-card>
      </v-col>
      <v-col lg="3" sm="8" cols="12">
        <v-card>
          <p>関連ガジェットを表示</p>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import Tags from '~/components/atoms/Tags.vue'
import Images from '~/components/atoms/Images.vue'
import CreatePostCommentDialog from '~/components/organisms/posts/CreatePostCommentDialog.vue'
import CreatePostReplyDialog from '~/components/organisms/posts/CreatePostReplyDialog.vue'
import DeletePostCommentDialog from '~/components/organisms/posts/DeletePostCommentDialog.vue'
import EditPostDialog from '~/components/organisms/posts/EditPostDialog.vue'
export default {
  components: {
    ErrorCard,
    Tags,
    Images,
    CreatePostCommentDialog,
    CreatePostReplyDialog,
    DeletePostCommentDialog,
    EditPostDialog
  },
  data () {
    return {
      postId: '',
      createCommentDialog: false,
      createReplyDialog: false,
      deleteCommentDialog: false,
      editPostDialog: false,
      deletePostDialog: false,
      parentComment: '',
      comment: '',
    }
  },
  async fetch ({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/posts/${params.id}`)
      .then(res => {
        store.dispatch('modules/post/setData', res)
        store.dispatch('modules/info/setError', false)
      })
      .catch(error => {
        store.dispatch('modules/info/setError', true)
      })
  },


  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      post: 'modules/post/data',
      error: 'modules/info/error'
    })
  },

  methods: {
    ...mapActions({
      reloadPostByCreateComment: 'modules/post/reloadPostByCreateComment',
      reloadPostByDeleteComment: 'modules/post/reloadPostByDeleteComment',
      reloadPostByEditPost: 'modules/post/reloadPostByEditPost',
      reloadPostByLikedPost: 'modules/post/reloadPostByLikedPost',
      reloadPostByDisLikedPost: 'modules/post/reloadPostByDisLikedPost'
    }),
    openCreateCommentDialog () {
      this.postId = this.post.id
      this.createCommentDialog = true
    },
    openCreateReplyDialog (comment) {
      this.postId = this.post.id
      this.parentComment = comment
      this.createReplyDialog = true
    },
    openDeleteCommentDialog (comment) {
      this.postId = this.post.id
      this.comment = comment
      this.deleteCommentDialog = true
    },
    openEditPostDialog () {
      this.postId = this.post.id
      this.editPostDialog = true
    },
    openDeletePostDialog () {
      this.postId = this.post.id
      this.deletePostDialog = true
    },
    createPostComment (payload) {
      this.reloadPostByCreateComment(payload)
    },
    createPostReply (payload) {
      this.reloadPostByCreateComment(payload)
    },
    deletePostComment (payload) {
      this.reloadPostByDeleteComment(payload)
    },
    editPost (payload) {
      this.reloadPostByEditPost(payload)
    },
    deletePost () {
      this.$router.push("/")
    },
    likedPost (payload) {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/likes', {
        user_id: this.$store.state.modules.user.data.id,
        post_id: payload.id
      })
        .then(() => {
          this.reloadPostByLikedPost(payload)
        })
    },
    disLikedPost (payload) {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/likes/delete', {
        params: {
          like: {
            user_id: this.$store.state.modules.user.data.id,
            post_id: payload.id
          }
        }
      })
        .then(() => {
          this.reloadPostByDisLikedPost(payload)
        })
    }
  }
}
</script>
<style scoped>

</style>