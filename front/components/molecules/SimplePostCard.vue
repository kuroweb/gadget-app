<template>
  <v-card
    class="mx-auto mt-5 pa-3"
    :to="`/posts/${post.id}`"
  >
    <v-row>
      <v-col cols="12">
        <h3>{{ post.description }}</h3>
      </v-col>
      <v-col cols="12">
        <p>{{ $moment(post.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
      </v-col>
      <v-col cols="12" v-if="post.images_url">
        <v-row justify="center">
          <v-col
            lg="3" sm="3" cols="3"
            v-for="(image, index) in post.images_url"
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
    post: {
      type: Object
    }
  }
}
</script>