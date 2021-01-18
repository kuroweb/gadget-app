<template>
  <v-card
    class="mx-auto ma-5"
    :to="`/boards/${board.id}`"
  >
    <v-card-title>
      <v-container>
        <v-row>
          <v-col>
            <span>{{ board.title }}</span>
          </v-col>
        </v-row>
      </v-container>
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
        </v-row>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
import Tags from "~/components/atoms/Tags.vue"
export default {
  components: {
    Tags,
  },
  props: {
    board: {
      type: Object
    }
  }
}
</script>
