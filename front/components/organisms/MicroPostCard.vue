<template>
  <v-card
    class="mx-auto"
    flat
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
      :deletemode="deletemode"
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
      :deletemode="deletemode"
      @deletePost="deletePost"
      @closeDialog="deletePostDialog = false"
    />
    <SupportDialog
      :dialog="supportDialog"
      @closeDialog="supportDialog = false"
    />
    <v-card-title>
      <v-container>
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
            <v-card flat :to="`/users/${post.user.id}`">
              <h3>{{ post.user.name }}</h3>
              <h6>{{ $moment(post.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
            </v-card>
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
              <!---------------->
              <!-- 管理メニュー -->
              <!---------------->
              <div v-if="$store.state.modules.user.data">
                <!-- adminユーザーの場合 -->
                <div v-if="$store.state.modules.user.data.admin === true">
                  <!-- 自身が作成したコンテンツの場合 -->
                  <div v-if="$store.state.modules.user.data.id === post.user.id">
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
                      @click="openDeletePostDialog(mode.owner)"
                    >
                      <v-icon>
                        mdi-delete
                      </v-icon>
                    </v-btn>
                  </div>
                  <div v-else>
                    <v-btn
                      icon
                      text
                      color="grey darken-2"
                      @click="openDeletePostDialog(mode.admin)"
                    >
                      <v-icon>
                        mdi-delete
                      </v-icon>
                    </v-btn>
                  </div>
                </div>
                <!-- 一般ユーザーの場合 -->
                <div v-if="$store.state.modules.user.data.admin === false">
                  <!-- 自身が作成したコンテンツの場合 -->
                  <div v-if="$store.state.modules.user.data.id === post.user.id">
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
                      @click="openDeletePostDialog(mode.owner)"
                    >
                      <v-icon>
                        mdi-delete
                      </v-icon>
                    </v-btn>
                  </div>
                </div>
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
            v-for="comment in post.post_comments"
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
                    <v-card flat :to="`/users/${comment.user.id}`">
                      <h3>{{ comment.user.name }}</h3>
                      <h6>{{ $moment(comment.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
                    </v-card>
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
                  <!---------------->
                  <!-- 管理メニュー -->
                  <!---------------->
                  <div v-if="$store.state.modules.user.data">
                    <!-- adminユーザーの場合 -->
                    <div v-if="$store.state.modules.user.data.admin === true">
                      <!-- 自身が作成したコンテンツの場合 -->
                      <div v-if="$store.state.modules.user.data.id === comment.user.id">
                        <v-btn
                          icon
                          text
                          color="grey darken-2"
                          @click="openDeleteCommentDialog(comment, mode.owner)"
                        >
                          <v-icon>
                            mdi-delete
                          </v-icon>
                        </v-btn>
                      </div>
                      <div v-else>
                        <v-btn
                          icon
                          text
                          color="grey darken-2"
                          @click="openDeleteCommentDialog(comment, mode.admin)"
                        >
                          <v-icon>
                            mdi-delete
                          </v-icon>
                        </v-btn>
                      </div>
                    </div>
                    <!-- 一般ユーザーの場合 -->
                    <div v-if="$store.state.modules.user.data.admin === false">
                      <!-- 自身が作成したコンテンツの場合 -->
                      <div v-if="$store.state.modules.user.data.id === comment.user.id">
                        <v-btn
                          icon
                          text
                          color="grey darken-2"
                          @click="openDeleteCommentDialog(comment, mode.owner)"
                        >
                          <v-icon>
                            mdi-delete
                          </v-icon>
                        </v-btn>
                      </div>
                    </div>
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
                          <v-card flat :to="`/users/${child.user.id}`">
                            <h3>{{ child.user.name }}</h3>
                            <h6>{{ $moment(child.created_at).format('YYYY年MM月DD日 HH時mm分') }}</h6>
                          </v-card>
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
                        justify="end"
                      >
                        <!---------------->
                        <!-- 管理メニュー -->
                        <!---------------->
                        <div v-if="$store.state.modules.user.data">
                          <!-- adminユーザーの場合 -->
                          <div v-if="$store.state.modules.user.data.admin === true">
                            <!-- 自身が作成したコンテンツの場合 -->
                            <div v-if="$store.state.modules.user.data.id === child.user.id">
                              <v-btn
                                icon
                                text
                                color="grey darken-2"
                                @click="openDeleteCommentDialog(child, mode.owner)"
                              >
                                <v-icon>
                                  mdi-delete
                                </v-icon>
                              </v-btn>
                            </div>
                            <div v-else>
                              <v-btn
                                icon
                                text
                                color="grey darken-2"
                                @click="openDeleteCommentDialog(child, mode.admin)"
                              >
                                <v-icon>
                                  mdi-delete
                                </v-icon>
                              </v-btn>
                            </div>
                          </div>
                          <!-- 一般ユーザーの場合 -->
                          <div v-if="$store.state.modules.user.data.admin === false">
                            <!-- 自身が作成したコンテンツの場合 -->
                            <div v-if="$store.state.modules.user.data.id === child.user.id">
                              <v-btn
                                icon
                                text
                                color="grey darken-2"
                                @click="openDeleteCommentDialog(child, mode.owner)"
                              >
                                <v-icon>
                                  mdi-delete
                                </v-icon>
                              </v-btn>
                            </div>
                          </div>
                        </div>
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
    <v-divider></v-divider>
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
import SupportDialog from '~/components/organisms/SupportDialog.vue'
export default {
  components: {
    Tags,
    Images,
    CreatePostCommentDialog,
    CreatePostReplyDialog,
    DeletePostCommentDialog,
    EditPostDialog,
    DeletePostDialog,
    SupportDialog
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
      supportDialog: false,
      parentComment: '',
      comment: '',
      mode: {
        owner: 'owner',
        admin: 'admin'
      },
      deletemode: ''
    }
  },
  methods: {
    ...mapActions({
      setFlash: "modules/info/setFlash",
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
    openDeleteCommentDialog (comment, payload) {
      this.deletemode = payload
      this.postId = this.post.id
      this.comment = comment
      this.deleteCommentDialog = true
    },
    openEditPostDialog () {
      this.postId = this.post.id
      this.editPostDialog = true
    },
    openDeletePostDialog (payload) {
      this.deletemode = payload
      this.postId = this.post.id
      this.deletePostDialog = true
    },
    openSupportDialog () {
      this.supportDialog = true
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
      if (this.$store.state.modules.user.data) {
        this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/likes', {
          user_id: this.$store.state.modules.user.data.id,
          post_id: payload.id
        })
          .then(() => {
            this.reloadPostsByLikedPost(payload)
            this.setFlash({
              status: true,
              message: "つぶやきにいいねしました"
            })
            setTimeout(() => {
              this.setFlash({
                status: false,
                message: ""
              })
            }, 2000)
          })
      } else {
        this.openSupportDialog()
      }
    },
    disLikedPost (payload) {
      if (this.$store.state.modules.user.data) {
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
            this.setFlash({
              status: true,
              message: "いいねを解除しました"
            })
            setTimeout(() => {
              this.setFlash({
                status: false,
                message: ""
              })
            }, 2000)
          })
      } else {
        this.openSupportDialog()
      }
    }
  }
}
</script>