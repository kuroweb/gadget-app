<template>
  <v-card
  class="mx-auto mt-5 pa-5"
  >
    <v-card-title>
      <v-row justify="center">
        <v-col>
          <v-avatar 
          size="62"
          >
            <img 
              v-if="post.user.avatar_url"
              :src="post.user.avatar_url"
              alt="Avatar"
            >
            <img
              v-else
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            >
          </v-avatar>
        </v-col>
        <v-col
          align-self="center"
        >
          <h3>{{ post.user.name }}</h3>
        </v-col>
      </v-row>
    </v-card-title>
    <v-card-subtitle>
      <Tags
        :tags="post.tags"
      />
    </v-card-subtitle>
    <v-card-text>
      <p>{{ post.description }}</p>
    </v-card-text>
    <!-- 投稿画像用のコンポーネントを作成 -->
    <Images
      :images="post.images_url"
    />
    <v-row>
      <v-col>
        <p>{{ post.created_at }}</p>
      </v-col>
      <v-col>
        
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
export default {
  components: {
    Tags,
    Images
  },
  props: {
    post: {
      type: Object
    }
  }
}
</script>
