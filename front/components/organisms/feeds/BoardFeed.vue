<template>
  <v-card
    v-if="renderStatus"
  >
    <v-tabs
      v-model="tab"
      fixed-tabs
      centered
      background-color="cyan darken-1"
      color="white"
      slider-color="orange"
      icons-and-text
    >
      <v-tab
        class="ma-0 pa-0"
        @change="changeNewBoards"
      >
        新着順
        <v-icon>mdi-clock-time-eight</v-icon>
      </v-tab>
      <v-tab
        class="ma-0 pa-0"
        @change="changeForumBoards"
      >
        雑談板
        <v-icon>mdi-forum</v-icon>
      </v-tab>
      <v-tab
        class="ma-0 pa-0"
        @change="changeQuestionBoards"
      >
        質問板
        <v-icon>mdi-comment-question</v-icon>
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab" touchless>
      <v-tab-item class="pa-1">
        <NewBoards
          :load="loadNewBoards"
        />
      </v-tab-item>
      <v-tab-item class="pa-1">
        <ForumBoards
          :load="loadForumBoards"
        />
      </v-tab-item>
      <v-tab-item class="pa-1">
        <QuestionBoards
          :load="loadQuestionBoards"
        />
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>
<script>
import NewBoards from '~/components/organisms/feeds/boardFeed/NewBoards.vue'
import ForumBoards from '~/components/organisms/feeds/boardFeed/ForumBoards.vue'
import QuestionBoards from '~/components/organisms/feeds/boardFeed/QuestionBoards.vue'
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
      loadNewBoards: false,
      loadForumBoards: false,
      loadQuestionBoards: false,
      tab: null
    }
  },
  watch: {
    render (newValue) {
      this.renderStatus = newValue
    }
  },
  methods: {
    changeNewBoards () {
      this.loadNewBoards = !this.loadNewBoards
    },
    changeForumBoards () {
      this.loadForumBoards = !this.loadForumBoards
    },
    changeQuestionBoards () {
      this.loadQuestionBoards = !this.loadQuestionBoards
    }
  }
}
</script>