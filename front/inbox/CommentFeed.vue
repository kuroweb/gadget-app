<template>
  <v-container
    v-if="displayStatus"
  >
    <v-row
      class="pa-3"
    >
      <v-btn
        block
        color="orange"
        dark
        rounded

      >
        コメントする
      </v-btn>
    </v-row>
    <v-card
      v-for="comment in comments"
      :key="comment.id"
      flat
    >
      <v-card
        class="mx-auto pa-5 mt-5"
      >
        <v-row>
          <v-col>
            <v-avatar 
              size="84"
            >
              <img 
                v-if="comment.user.avatar_url"
                :src="comment.user.avatar_url"
                alt="Avatar"
              >
              <img
                v-else
                src="~/assets/images/default_icon.jpeg"
                alt="Avatar"
              >
            </v-avatar>
          </v-col>
          <v-col align-self="center">
            <h3>{{ comment.user.name }}</h3>
          </v-col>
        </v-row>
        <p>{{ comment.description }}</p>
        <Images
          :images="comment.images_url"
        />
        <v-row
          justify="end"
        >
          <v-btn
            rounded
            color="success"
            class="cyan darken-1"

          >
            返信
          </v-btn>
        </v-row>
        <v-row justify="end">
          <v-icon

          >
            mdi-delete
          </v-icon>
        </v-row>
      </v-card>
      <v-timeline
        v-if="comment.childComments.length !== 0"
        align-top
      >
        <v-timeline-item
          v-for="child in comment.childComments"
          :key="child.id"
          small
          fill-dot
          color="grey"
          right
          hide-dot
        >
          <v-card
            color="grey"
            dark
            
          >
            <v-card-title class="title">
              <v-icon dark>mdi-reply</v-icon>
              返信コメント
            </v-card-title>
            <v-card-text class="white text--primary">
              <v-row>
                <v-col>
                  <v-avatar 
                    size="48"
                  >
                    <img 
                      v-if="child.user.avatar_url"
                      :src="child.user.avatar_url"
                      alt="Avatar"
                    >
                    <img
                      v-else
                      src="~/assets/images/default_icon.jpeg"
                      alt="Avatar"
                    >
                  </v-avatar>
                </v-col>
                <v-col align-self="center">
                  <h3>{{ child.user.name }}</h3>
                </v-col>
              </v-row>
              <p>{{ child.description }}</p>
              <Images
                :images="child.images_url"
              />
            </v-card-text>
          </v-card>
        </v-timeline-item>
      </v-timeline>
    </v-card>
  </v-container>
</template>
<script>
export default {
  props: {
    display: {
      type: Boolean
    },
    comments: {
      type: Array
    }
  },
  data () {
    return {
      displayStatus: false
    }
  },
  watch: {
    display (newValue) {
      this.displayStatus = newValue
    }
  }
}
</script>