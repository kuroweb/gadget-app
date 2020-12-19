<template>
  <v-card
    v-if="renderStatus"
  >
    <v-tabs
      fixed-tabs
      centered
      background-color="cyan darken-1"
      color="white"
      slider-color="orange"
      icons-and-text
    >
      <v-tab class="ma-0 pa-0">
        新着順
        <v-icon>mdi-clock-time-eight</v-icon>
      </v-tab>
      <v-tab class="ma-0 pa-0">
        雑談板
        <v-icon>mdi-forum</v-icon>
      </v-tab>
      <v-tab class="ma-0 pa-0">
        質問板
        <v-icon>mdi-comment-question</v-icon>
      </v-tab>
      <v-tab-item>
        <NewBoards/>
      </v-tab-item>
      <v-tab-item>
        <ForumBoards/>
      </v-tab-item>
      <v-tab-item>
        <QuestionBoards/>
      </v-tab-item>
    </v-tabs>
  </v-card>
</template>
<script>
import NewBoards from '~/components/organisms/feeds/boardList/NewBoards.vue'
import ForumBoards from '~/components/organisms/feeds/boardList/ForumBoards.vue'
import QuestionBoards from '~/components/organisms/feeds/boardList/QuestionBoards.vue'
export default {
  components: {
    NewBoards,
    ForumBoards,
    QuestionBoards
  },
  props: {
    render: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      renderStatus: this.render,
    }
  },
  watch: {
    render (newValue) {
      this.renderStatus = newValue
    }
  },
  methods: {
  }
}
</script>