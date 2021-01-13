<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFount"
      message="掲示板が存在しません。"
    />
    <CreateBoardCommentDialog
      :dialog="createCommentDialog"
      :boardId="boardId"
      @createBoardComment="createBoardComment"
      @closeDialog="createCommentDialog = false"
    />
    <CreateBoardReplyDialog
      :dialog="createReplyDialog"
      :boardId="boardId"
      :parentComment="parentComment"
      @createBoardReply="createBoardReply"
      @closeDialog="createReplyDialog = false"
    />
    <DeleteBoardCommentDialog
      :dialog="deleteCommentDialog"
      :boardId="boardId"
      :comment="comment"
      @deleteBoardComment="deleteBoardComment"
      @closeDialog="deleteCommentDialog = false"
    />
    <EditBoardDialog
      :dialog="editBoardDialog"
      :boardId="boardId"
      @editBoard="editBoard"
      @closeDialog="editBoardDialog = false"
    />
    <DeleteBoardDialog
      :dialog="deleteBoardDialog"
      :boardId="boardId"
      @deleteBoard="deleteBoard"
      @closeDialog="deleteBoardDialog = false"
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
            <v-toolbar-title>【{{ board.board_type }}】 {{ board.title }}</v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-card
              class="mx-auto pa-3"
            >
              <v-row justify="center">
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
                <v-col
                  align-self="center"
                >
                  <h3>{{ board.user.name }}</h3>
                </v-col>
              </v-row>
              <v-card
                flat
                :to="`/boards/${board.id}`"
              >
                <span>{{ board.description }}</span>
              </v-card>
              <Images
                :images="board.images_url"
              />
              <Tags
                :tags="board.tags"
              />
              <v-row>
                <v-col cols="8" align-self="center">
                  <span>{{ $moment(board.created_at).format('YYYY年MM月DD日 HH時mm分') }}</span>
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
                    <span>{{ board.commentCounts }}</span>
                  </v-row>
                </v-col>
              </v-row>
              <!-- 管理者メニュー -->
              <v-sheet
                color="grey lighten-2"
                rounded
                v-if="$store.state.modules.user.data && board.user.id === $store.state.modules.user.data.id"
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
                        @click="openEditBoardDialog"
                      >
                        <v-icon>
                          mdi-pencil-box-multiple
                        </v-icon>
                      </v-btn>
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        class="mr-3"
                        @click="openDeleteBoardDialog"
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
              v-for="comment in board.board_comments"
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
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
import CreateBoardCommentDialog from '~/components/organisms/boards/CreateBoardCommentDialog.vue'
import CreateBoardReplyDialog from '~/components/organisms/boards/CreateBoardReplyDialog.vue'
import DeleteBoardCommentDialog from '~/components/organisms/boards/DeleteBoardCommentDialog.vue'
import EditBoardDialog from '~/components/organisms/boards/EditBoardDialog.vue'
import DeleteBoardDialog from '~/components/organisms/boards/DeleteBoardDialog.vue'
export default {
  components: {
    ErrorCard,
    Tags,
    Images,
    CreateBoardCommentDialog,
    CreateBoardReplyDialog,
    DeleteBoardCommentDialog,
    EditBoardDialog,
    DeleteBoardDialog
  },
  data () {
    return {
      boardId: '',
      createCommentDialog: false,
      createReplyDialog: false,
      deleteCommentDialog: false,
      editBoardDialog: false,
      deleteBoardDialog: false,
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
    ...mapActions({
      reloadBoardByEditBoard: 'modules/board/reloadBoardByEditBoard',
      reloadBoardByCreateComment: 'modules/board/reloadBoardByCreateComment',
      reloadBoardByDeleteComment: 'modules/board/reloadBoardByDeleteComment'
    }),
    // ダイアログ関連
    openCreateCommentDialog () {
      this.boardId = this.board.id
      this.createCommentDialog = true
    },
    openCreateReplyDialog (comment) {
      this.boardId = this.board.id
      this.parentComment = comment
      this.createReplyDialog = true
    },
    openDeleteCommentDialog (comment) {
      this.boardId = this.board.id
      this.comment = comment
      this.deleteCommentDialog = true
    },
    openEditBoardDialog () {
      this.boardId = this.board.id
      this.editBoardDialog = true
    },
    openDeleteBoardDialog () {
      this.boardId = this.board.id
      this.deleteBoardDialog = true
    },
    editBoard (payload) {
      this.reloadBoardByEditBoard(payload)
    },
    deleteBoard () {
      this.$router.push("/")
    },
    createBoardComment (payload) {
      this.reloadBoardByCreateComment(payload)
    },
    createBoardReply (payload) {
      this.reloadBoardByCreateComment(payload)
    },
    deleteBoardComment (payload) {
      this.reloadBoardByDeleteComment(payload)
    }
  }
}
</script>
<style scoped>

</style>