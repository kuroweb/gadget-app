<template>
  <v-card
    class="mx-auto ma-5"
  >
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
    <v-card-title>
      <v-container dense>
        <v-row>
          <v-col cols="4">
            <v-avatar 
            size="64"
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
          <v-col cols="8">
            <h3>{{ post.user.name }}</h3>
            <h6>{{ $moment(post.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
          </v-col>
          <v-col cols="12">
            <Tags
              :tags="post.tags"
            />
          </v-col>
        </v-row>
      </v-container>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card
              flat
              :to="`/posts/${post.id}`"
            >
              <span>{{ post.description }}</span>
            </v-card>
          </v-col>
          <v-col cols="12" v-if="post.images_url">
            <Images
              :images="post.images_url"
            />
          </v-col>
          <v-col cols="12">
            <v-row justify="end" class="pr-3">
              <div
                v-if="$store.state.modules.user.data && post.user.id === $store.state.modules.user.data.id"
              >
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
                >
                  <v-icon>
                    mdi-delete
                  </v-icon>
                </v-btn>
              </div>
              <v-btn
                v-if="commentFeed === true"
                icon
                text
                color="blue"
                @click="toggleCommentFeed"
              >
                <v-icon>
                  mdi-comment
                </v-icon>
              </v-btn>
              <v-btn
                v-if="commentFeed === false"
                icon
                text
                @click="toggleCommentFeed"
              >
                <v-icon>
                  mdi-comment-outline
                </v-icon>
              </v-btn>
              <p>{{ post.commentCounts }}</p>
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
              <p>{{ post.likedUsersCounts }}</p>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
    <v-card flat>
      <v-container
        v-if="commentFeed"
      >
        <v-row>
          <v-col cols="12">
            <v-btn
              block
              color="orange"
              dark
              rounded
              @click="openCreateCommentDialog"
            >
              コメントする
            </v-btn>
          </v-col>
          <v-col
            cols="12"
            v-for="comment in post.comments"
            :key="comment.id"
          >
            <v-card
              class="mx-auto pa-3"
            >
              <v-container>
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
                    <h6>{{ $moment(comment.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
                  </v-col>
                </v-row>
                <Images
                  :images="comment.images_url"
                />
                <v-row>
                  <v-col>
                    <span>{{ comment.description }}</span>
                  </v-col>
                </v-row>
                <v-row justify="end">
                  <div
                    v-if="$store.state.modules.user.data && comment.user.id === $store.state.modules.user.data.id"
                  >
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
                  </div>
                  <v-btn
                    rounded
                    color="success"
                    class="cyan darken-1"
                    @click="openCreateReplyDialog(comment)"
                  >
                    返信
                  </v-btn>
                </v-row>
              </v-container>
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
                    <v-container>
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
                          <h6>{{ $moment(child.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
                        </v-col>
                      </v-row>
                      <v-row>
                        <v-col>
                          <span>{{ child.description }}</span>
                        </v-col>
                      </v-row>
                      <Images
                        :images="child.images_url"
                      />
                      <v-row
                        v-if="$store.state.modules.user.data && child.user.id === $store.state.modules.user.data.id"
                        justify="end"
                      >
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
                    </v-container>
                  </v-card-text>
                </v-card>
              </v-timeline-item>
            </v-timeline>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
import CreatePostCommentDialog from '~/components/organisms/posts/CreatePostCommentDialog.vue'
import CreatePostReplyDialog from '~/components/organisms/posts/CreatePostReplyDialog.vue'
import DeletePostCommentDialog from '~/components/organisms/posts/DeletePostCommentDialog.vue'
import EditPostDialog from '~/components/organisms/posts/EditPostDialog.vue'
import DeletePostDialog from '~/components/organisms/posts/DeletePostDialog.vue'
export default {
  components: {
    Tags,
    Images,
    CreatePostCommentDialog,
    CreatePostReplyDialog,
    DeletePostCommentDialog,
    EditPostDialog,
    DeletePostDialog
  },
  props: {
    post: {
      type: Object
    }
  },
  data () {
    return {
      commentFeed: false,
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
  methods: {
    ...mapActions({
      reloadPostsByCreateComment: 'modules/post/reloadPostsByCreateComment',
      reloadPostsByDeleteComment: 'modules/post/reloadPostsByDeleteComment',
      reloadPostsByEditPost: 'modules/post/reloadPostsByEditPost',
      reloadPostsByDeletePost: 'modules/post/reloadPostsByDeletePost',
      reloadPostsByLikedPost: 'modules/post/reloadPostsByLikedPost',
      reloadPostsByDisLikedPost: 'modules/post/reloadPostsByDisLikedPost'
    }),
    toggleCommentFeed () {
      this.commentFeed = !this.commentFeed
    },
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
      this.reloadPostsByCreateComment(payload)
    },
    createPostReply (payload) {
      this.reloadPostsByCreateComment(payload)
    },
    deletePostComment (payload) {
      this.reloadPostsByDeleteComment(payload)
    },
    editPost (payload) {
      this.reloadPostsByEditPost(payload)
    },
    deletePost (payload) {
      this.reloadPostsByDeletePost(payload)
    },
    likedPost (payload) {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/likes', {
        user_id: this.$store.state.modules.user.data.id,
        post_id: payload.id
      })
        .then(() => {
          this.reloadPostsByLikedPost(payload)
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
          this.reloadPostsByDisLikedPost(payload)
        })
    }
  }
}
</script>