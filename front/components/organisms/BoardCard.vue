<template>
  <v-card
    class="mx-auto"
    flat
  >
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
    <v-card-title>
      <v-row>
        <v-col cols="12">
          <v-card flat :to="`/boards/${board.id}`">
            <span>{{ board.title }}</span>
          </v-card>
        </v-col>
      </v-row>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col>
            <span>コメント数：</span>
            <span>{{ board.commentCounts }}</span>
          </v-col>
          <v-col v-if="board.board_type === '雑談'">
            <v-row justify="end">
              <v-chip
                class="ma-2"
                color="grey"
                label
                text-color="white"
              >
                <v-icon left>
                  mdi-forum
                </v-icon>
                  {{ board.board_type }}
              </v-chip>
            </v-row>
          </v-col>
          <v-col v-if="board.board_type === '質問'">
            <v-row justify="end">
              <v-chip
                class="ma-2"
                color="grey"
                label
                text-color="white"
              >
                <v-icon left>
                  mdi-comment-question
                </v-icon>
                  {{ board.board_type }}
              </v-chip>
            </v-row>
          </v-col>
          <v-col cols="12" v-if="$store.state.modules.user.data">
            <v-row justify="end">
              <!---------------->
              <!-- 管理メニュー -->
              <!---------------->
              <div v-if="$store.state.modules.user.data">
                <!-- adminユーザーの場合 -->
                <div v-if="$store.state.modules.user.data.admin === true">
                  <!-- 自身が作成したコンテンツの場合 -->
                  <div v-if="$store.state.modules.user.data.id === board.user.id">
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
                      @click="openDeleteBoardDialog"
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
                      @click="openDeleteBoardDialog"
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
                  <div v-if="$store.state.modules.user.data.id === board.user.id">
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
                      @click="openDeleteBoardDialog"
                    >
                      <v-icon>
                        mdi-delete
                      </v-icon>
                    </v-btn>
                  </div>
                </div>
              </div>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
    <v-divider></v-divider>
  </v-card>
</template>
<script>
import { mapActions } from 'vuex'
import EditBoardDialog from '~/components/organisms/boards/EditBoardDialog.vue'
import DeleteBoardDialog from '~/components/organisms/boards/DeleteBoardDialog.vue'
import Tags from "~/components/atoms/Tags.vue"
export default {
  components: {
    Tags,
    EditBoardDialog,
    DeleteBoardDialog
  },
  props: {
    board: {
      type: Object
    }
  },
  data () {
    return {
      boardId: '',
      editBoardDialog: false,
      deleteBoardDialog: false,
    }
  },
  methods: {
    ...mapActions({
      reloadBoardsByEditBoard: 'modules/board/reloadBoardsByEditBoard',
      reloadBoardsByDeleteBoard: 'modules/board/reloadBoardsByDeleteBoard',
    }),
    openEditBoardDialog () {
      this.boardId = this.board.id
      this.editBoardDialog = true
    },
    openDeleteBoardDialog () {
      this.boardId = this.board.id
      this.deleteBoardDialog = true
    },
    editBoard (payload) {
      this.reloadBoardsByEditBoard(payload)
    },
    deleteBoard (payload) {
      this.reloadBoardsByDeleteBoard(payload)
    }
  }
}
</script>
