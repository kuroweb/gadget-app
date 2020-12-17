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
          <v-icon @click="toggleCommentFeed">
            mdi-comment
          </v-icon>
          <span class="ml-1">{{ post.commentCounts }}</span>
          <v-icon class="ml-3">
            mdi-cards-heart
          </v-icon>
          <span class="ml-1 pr-3">{{ post.likedUsersCounts }}</span>
        </v-row>
        <v-row justify="end" class="mt-3">
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
          @click="openCommentDialog"
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
              @click="openReplyDialog(comment)"
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
      reloadPostsByCreate: 'modules/post/reloadPostsByCreate',
      reloadPostsByDeleteComment: 'modules/post/reloadPostsByDeleteComment',
      reloadPostsByEdit: 'modules/post/reloadPostsByEdit',
      reloadPostsByDeletePost: 'modules/post/reloadPostsByDeletePost'
    }),
    toggleCommentFeed () {
      this.commentFeed = !this.commentFeed
    },
    openCommentDialog () {
      this.postId = this.post.id
      this.commentDialog = true
    },
    openReplyDialog (comment) {
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
      this.reloadPostsByCreate(payload)
    },
    createPostReply (payload) {
      this.reloadPostsByCreate(payload)
    },
    deletePostComment (payload) {
      this.reloadPostsByDeleteComment(payload)
    },
    editPost (payload) {
      this.reloadPostsByEdit(payload)
    },
    deletePost (payload) {
      this.reloadPostsByDeletePost(payload)
    }
  }
}
</script>