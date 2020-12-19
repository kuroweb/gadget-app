<template>
  <v-card
    class="mx-auto mt-5 pa-5"
  >
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
      <span>{{ post.description }}</span>
    </v-card>
    <Images
      :images="post.images_url"
    />
    <Tags
      :tags="post.tags"
    />
    <v-row>
      <v-col cols="8">
        <span>{{ $moment(post.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
      </v-col>
      <v-col cols="4" >
        <v-row justify="end">
          <v-icon @click="toggleCommentFeed">
            mdi-comment
          </v-icon>
          <span class="ml-1">{{ post.commentCounts }}</span>
          <v-icon class="ml-3">
            mdi-cards-heart
          </v-icon>
          <span class="ml-1 pr-3">{{ post.likedUsersCounts }}</span>
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
        <v-col cols="6">
          <span class="ml-3">管理メニュー</span>
        </v-col>
        <v-col cols="6">
          <v-row justify="end">
            <v-icon
              class="ml-3 pr-3"
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
    </v-sheet>
    <v-container
      v-if="commentFeed"
    >
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
          class="mx-auto pa-5"
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
          <span>{{ comment.description }}</span>
          <Images
            :images="comment.images_url"
          />
          <v-row>
            <v-col align-self="center">
              <span>{{ $moment(comment.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
            </v-col>
            <v-col>
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
              <v-col cols="6">
                <span class="ml-3">管理メニュー</span>
              </v-col>
              <v-col cols="6">
                <v-row justify="end">
                  <v-icon
                    class="ml-3 pr-6"
                    @click="openDeleteCommentDialog(comment)"
                  >
                    mdi-delete
                  </v-icon>
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
                <v-row dense justify="home">
                    <span>{{ $moment(child.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
                </v-row>
                <!-- 管理者メニュー -->
                <v-sheet
                  color="grey lighten-2"
                  rounded
                  v-if="$store.state.modules.user.data && child.user.id === $store.state.modules.user.data.id"
                >
                  <v-row dense>
                    <v-col cols="6">
                      <span class="ml-3">管理メニュー</span>
                    </v-col>
                    <v-col cols="6">
                      <v-row justify="end">
                        <v-icon
                          class="ml-3 pr-6"
                          @click="openDeleteCommentDialog(comment)"
                        >
                          mdi-delete
                        </v-icon>
                      </v-row>
                    </v-col>
                  </v-row>
                </v-sheet>
              </v-card-text>
            </v-card>
          </v-timeline-item>
        </v-timeline>
      </v-card>
    </v-container>
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
      commentDialog: false,
      replyDialog: false,
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
      reloadPostsByDeletePost: 'modules/post/reloadPostsByDeletePost'
    }),
    toggleCommentFeed () {
      this.commentFeed = !this.commentFeed
    },
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
    }
  }
}
</script>