<template>
  <v-card
    class="mx-auto mt-5 pa-3"
  >
    <v-card
      flat
      :to="`/boards/${board.id}`"
    >
      <v-row>
        <v-col cols="12">
          <span>{{ board.title }}</span>
        </v-col>
        <v-col cols="12">
          <span>コメント数：</span>
          <span>{{ board.commentCounts }}</span>
        </v-col>
      </v-row>
    </v-card>
    <Tags
      :tags="board.tags"
    />
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
