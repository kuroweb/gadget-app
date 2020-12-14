<template>
  <v-card
    class="mx-auto mt-5 pa-5"
  >
    <v-card
      flat
      :to="`/boards/${board.id}`"
    >
      <h3>{{ board.title }}</h3>
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
