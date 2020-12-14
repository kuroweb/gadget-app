<template>
  <v-container>
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
          to="/boards/create"
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
import BoardCard from '~/components/molecules/BoardCard.vue'
export default {
  components: {
    BoardCard,
  },
  data () {
    return {
      loading: true,
      boards: []
    }
  },
  async mounted () {
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/boards?board_type=雑談`)
      .then(res => {
        setTimeout(this.stopLoading, 1000)
        return res
      })
      .then(res => {
        this.boards = res
      })
  },
  methods: {
    stopLoading () {
      this.loading = false
    }
  }
}
</script>