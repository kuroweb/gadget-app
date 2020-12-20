<template>
  <v-container>
    <CreateBoardDialog
      :dialog="createBoardDialog"
      @createBoard="createBoard"
      @closeDialog="createBoardDialog = false"
    />
    <v-row v-if="loading">
      <v-col cols="12">
        <v-skeleton-loader
          class="mx-auto"
          type="card"
          v-for="n in 5"
          :key="n.id"
        />
      </v-col>
    </v-row>
    <v-row v-if="loading === false">
      <v-col cols="12">
        <v-btn
          block
          color="orange"
          dark
          rounded
          @click="openCreateBoardDialog"
        >
          新しいトピックを追加する
        </v-btn>
      </v-col>
      <v-col cols="12">
        <BoardCard
          v-for="board in boards"
          :key="board.id"
          :board="board"
        />
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import BoardCard from '~/components/organisms/BoardCard.vue'
import CreateBoardDialog from '~/components/organisms/boards/CreateBoardDialog.vue'
export default {
  components: {
    BoardCard,
    CreateBoardDialog
  },
  data () {
    return {
      loading: true,
      createBoardDialog: false
    }
  },
  props: {
    load: null
  },
  watch: {
    async load () {
      this.loading = true
      await this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/boards?board_type=質問')
        .then(res => {
          this.setBoards(res)
          setTimeout(this.stopLoading, 500)
        })
    }
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/boards?board_type=質問`)
      .then(res => {
        this.setBoards(res)
        setTimeout(this.stopLoading, 500)
      })
  },
  computed: {
    ...mapGetters({
      boards: 'modules/board/boards'
    })
  },
  methods: {
    ...mapActions({
      setBoards: 'modules/board/setBoards',
      reloadBoardsByCreateBoard: 'modules/board/reloadBoardsByCreateBoard'
    }),
    stopLoading () {
      this.loading = false
    },
    openCreateBoardDialog () {
      this.createBoardDialog = true
    },
    createBoard (payload) {
      this.reloadBoardsByCreateBoard(payload)
    }
  }
}
</script>