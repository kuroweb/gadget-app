<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFount"
      message="掲示板が存在しません。"
    />
    <CreateBoardCommentDialog
      :dialog="commentDialog"
      :boardId="boardId"
      @closeDialog="commentDialog = false"
    />
    <CreateBoardReplyDialog
      :dialog="replyDialog"
      :boardId="boardId"
      :parentComment="parentComment"
      @closeDialog="replyDialog = false"
    />
    <DeleteBoardCommentDialog
      :dialog="deleteCommentDialog"
      :boardId="boardId"
      :comment="comment"
      @closeDialog="deleteCommentDialog = false"
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
        <v-card
          v-if="board"
        >
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>{{ board.board_type }}掲示板</v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-card
              class="mx-auto pa-5"
            >
              <v-row>
                <v-col>
                  <v-avatar
                    size="84"
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
                <v-col align-self="center">
                  <h3>{{ board.user.name }}</h3>
                  <Tags
                    :tags="board.tags"
                  />
                </v-col>
              </v-row>
              <p>{{ board.description }}</p>
              <Images
                :images="board.images_url"
              />
            </v-card>
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
              v-for="comment in board.board_comments"
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
                v-if="comment.childComments.length !== 0"
                align-top
              >
                <v-timeline-item
                  v-for="child in comment.childComments"
                  :key="child.id"
                  small
                  fill-dot
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
import { mapGetters } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import CreateBoardCommentDialog from '~/components/organisms/boards/CreateBoardCommentDialog.vue'
import CreateBoardReplyDialog from '~/components/organisms/boards/CreateBoardReplyDialog.vue'
import DeleteBoardCommentDialog from '~/components/organisms/boards/DeleteBoardCommentDialog.vue'
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
export default {
  components: {
    ErrorCard,
    CreateBoardCommentDialog,
    CreateBoardReplyDialog,
    DeleteBoardCommentDialog,
    Tags,
    Images
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
      board: 'modules/board/data',
      error: 'modules/info/error'
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