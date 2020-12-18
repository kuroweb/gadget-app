<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="投稿が存在しません。"
    />
    <CreatePostCommentDialog
      :dialog="commentDialog"
      :postId="postId"
      @createPostComment="createPostComment"
      @closeDialog="commentDialog = false"
    />
    <CreatePostReplyDialog
      :dialog="replyDialog"
      :postId="postId"
      :parentComment="parentComment"
      @createPostReply="createPostReply"
      @closeDialog="replyDialog = false"
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
              class="mx-auto pa-5"
            >
              <v-row justify="center">
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
                <p>{{ post.description }}</p>
              </v-card>
              <Images
                :images="post.images_url"
              />
              <Tags
                :tags="post.tags"
              />
              <v-row>
                <v-col cols="8">
                  <p>{{ post.created_at }}</p>
                </v-col>
                <v-col cols="4" >
                  <v-row justify="end">
                    <v-icon
                      @click="openEditPostDialog"
                    >
                      mdi-pencil-box-multiple
                    </v-icon>
                    <v-icon
                      class="ml-3 pr-6"
                      @click="openDeletePostDialog"
                    >
                      mdi-delete
                    </v-icon>
                  </v-row>
                </v-col>
              </v-row>
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
            <v-card
              v-for="comment in post.comments"
              :key="comment.id"
              flat
            >
              <v-card
                class="mx-auto pa-5 mt-5"
              >
                <v-row>
                  <v-col>
                    <v-avatar 
                      size="84"
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
                <p>{{ comment.description }}</p>
                <Images
                  :images="comment.images_url"
                />
                <v-row
                  justify="end"
                >
                  <v-btn
                    rounded
                    color="success"
                    class="cyan darken-1"
                    @click="openCreateReplyDialog(comment)"
                  >
                    返信
                  </v-btn>
                </v-row>
                <v-row justify="end">
                  <v-icon
                    @click="openDeleteCommentDialog(comment)"
                  >
                    mdi-delete
                  </v-icon>
                </v-row>
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
                    dark
                  >
                    <v-card-title class="title">
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
                      <p>{{ child.description }}</p>
                      <Images
                        :images="child.images_url"
                      />
                      <v-row justify="end">
                        <v-icon
                          color="grey darken-1"
                          @click="openDeleteCommentDialog(child)"
                        >
                          mdi-delete
                        </v-icon>
                      </v-row>
                    </v-card-text>
                  </v-card>
                </v-timeline-item>
              </v-timeline>
            </v-card>
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
      commentDialog: false,
      replyDialog: false,
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
        store.commit('modules/info/setError', false)
      })
      .catch(error => {
        store.commit('modules/info/setError', true)
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
      reloadPostByEditPost: 'modules/post/reloadPostByEditPost'
    }),
    openCreateCommentDialog () {
      this.postId = this.post.id
      this.commentDialog = true
    },
    openCreateReplyDialog (comment) {
      this.postId = this.post.id
      this.parentComment = comment
      this.replyDialog = true
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
    deletePost (payload) {
      this.$router.push("/")
    }
  }
}
</script>
<style>

</style>