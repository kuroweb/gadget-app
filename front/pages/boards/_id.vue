<template>
  <v-container>
    <ErrorCard
      :display="!board"
      title="404NotFount"
      message="掲示板が存在しません。"
    />
    <CreateCommentDialog
      :dialog="commentDialog"
      :boardId="boardId"
      @closeDialog="commentDialog = false"
    />
    <CreateReplyDialog
      :dialog="replyDialog"
      :boardId="boardId"
      :parentComment="parentComment"
      @closeDialog="replyDialog = false"
    />
    <DeleteCommentDialog
      :dialog="deleteCommentDialog"
      :boardId="boardId"
      :comment="comment"
      @closeDialog="deleteCommentDialog = false"
    />
    <v-card
      v-if="board"
      class="mx-auto mt-5 pa-5"
    >
      <v-card-title>
        <v-row>
          <v-col>
            <v-avatar 
              size="62"
            >
              <img 
                v-if="board.user.avatar_url"
                :src="board.user.avatar_url"
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
            <h3>{{ board.user.name }}</h3>
          </v-col>
        </v-row>
        <v-row>
          <p
            v-for="tag in board.tags"
            :key="tag.id"
          >
            {{tag.tag_name}}
          </p>
        </v-row>
      </v-card-title>
      <v-card-text>
        <v-row>
          <p>{{ board.description }}</p>
        </v-row>
        <v-row
          justify="center"
          v-if="board.images_url !== null"
        >
          <v-avatar v-if="board.images_url.length > 0">
            <img :src="board.images_url[0]">
          </v-avatar>
          <v-avatar v-if="board.images_url.length > 1">
            <img :src="board.images_url[1]">
          </v-avatar>
          <v-avatar v-if="board.images_url.length > 2">
            <img :src="board.images_url[2]">
          </v-avatar>
          <v-avatar v-if="board.images_url.length > 3">
            <img :src="board.images_url[3]">
          </v-avatar>
        </v-row>
      </v-card-text>
      <v-row justify="center">
        <v-btn
          color="success"
          class="white--text"
          @click="openCommentDialog"
        >
          コメントする
        </v-btn>
      </v-row>
    </v-card>
    <v-card
      v-for="comment in board.board_comments"
      :key="comment.id"
      flat
    >
      <v-card
        class="mx-auto mt-5 pa-5"
      >
        <v-row>
          <v-col>
            <v-avatar 
              size="62"
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
          <v-col>
            <h3>{{ comment.user.name }}</h3>
          </v-col>
        </v-row>
        <v-row>
          <p>{{ comment.description }}</p>
        </v-row>
        <v-row
          justify="end"
        >
          <v-btn
            color="success"
            class="white--text"
            @click="openReplyDialog(comment)"
          >
            返信する
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
      <v-card
        v-for="child in comment.childComments"
        :key="child.id"
        class="mx-auto mt-5 pa-5"
      >
        <p>@返信コメント</p>
        <v-row>
          <v-avatar 
            size="62"
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
          <p>{{ child.user.name }}</p>
        </v-row>
        <p>{{ child.description }}</p>
        <v-row justify="end">
          <v-icon
            @click="openDeleteCommentDialog(child)"
          >
            mdi-delete
          </v-icon>
        </v-row>
      </v-card>
    </v-card>
  </v-container>
</template>
<script>
import { mapGetters } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import CreateCommentDialog from '~/components/organisms/boards/CreateCommentDialog.vue'
import CreateReplyDialog from '~/components/organisms/boards/CreateReplyDialog.vue'
import DeleteCommentDialog from '~/components/organisms/boards/DeleteCommentDialog.vue'
export default {
  components: {
    ErrorCard,
    CreateCommentDialog,
    CreateReplyDialog,
    DeleteCommentDialog
  },
  data () {
    return {
      boardId: '',
      commentDialog: false,
      replyDialog: false,
      deleteCommentDialog: false,
      parentComment: '',
      comment: '',
    }
  },
  async fetch ({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/boards/${params.id}`)
      .then(res => {
        // 掲示板の情報をコミット
        store.dispatch('modules/board/setData', res)
      })
      .catch(error => {
        console.log('掲示板が存在しません。')
      })
  },


  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      board: 'modules/board/data'
    })
  },

  methods: {
    // ダイアログ関連
    openCommentDialog () {
      this.boardId = this.board.id
      this.commentDialog = true
    },
    openReplyDialog (comment) {
      this.boardId = this.board.id
      this.parentComment = comment
      this.replyDialog = true
    },
    openDeleteCommentDialog (comment) {
      this.boardId = this.board.id
      this.comment = comment
      this.deleteCommentDialog = true
    }
  }
}
</script>
<style>

</style>