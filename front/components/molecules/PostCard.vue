<template>
  <v-card
    class="mx-auto mt-5 pa-5"
  >
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
    <v-card
      flat
      :to="`/posts/${post.id}`"
    >
      <p>{{ post.description }}</p>
    </v-card>
    <Images
      :images="post.images_url"
    />
    <Tags
      :tags="post.tags"
    />
    <v-row>
      <v-col>
        <p>{{ post.created_at }}</p>
      </v-col>
      <v-col>
        <v-icon @click="toggleCommentFeed">
          mdi-comment
        </v-icon>
      </v-col>
    </v-row>
    <v-row>
      <CommentFeed
        :display="commentFeed"
        :comments="post.comments"
      />
    </v-row>
  </v-card>
</template>

<script>
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
import CommentFeed from "~/components/molecules/CommentFeed.vue"
export default {
  components: {
    Tags,
    Images,
    CommentFeed
  },
  props: {
    post: {
      type: Object
    }
  },
  data () {
    return {
      commentFeed: false
    }
  },
  methods: {
    toggleCommentFeed () {
      this.commentFeed = !this.commentFeed
    }
  }
}
</script>
