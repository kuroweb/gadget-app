<template>
  <v-card
    class="mx-auto mt-5 pa-3"
    :to="`/boards/${board.id}`"
  >
    <v-row>
      <v-col cols="12">
        <h3>{{ board.title }}</h3>
      </v-col>
      <v-col cols="12">
        <p>{{ board.description }}</p>
        <p>{{ $moment(board.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
      </v-col>
      <v-col cols="12" v-if="board.images_url">
        <v-row justify="center">
          <v-col
            lg="3" sm="3" cols="3"
            v-for="(image, index) in board.images_url"
            :key="index"
          >
            <v-img
              :src="image"
              aspect-ratio="1"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-card>
</template>
<script>
export default {
  props: {
    board: {
      type: Object
    }
  }
}
</script>