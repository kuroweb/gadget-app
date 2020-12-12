<template>
  <v-card
    v-if="renderStatus"
  >
    <v-tabs
      centered
      background-color="cyan darken-1"
      color="white"
      slider-color="orange"
      icons-and-text
    >
      <v-tab>
        新着順
        <v-icon>mdi-clock-time-eight</v-icon>
      </v-tab>
      <v-tab>
        タイムライン
        <v-icon>mdi-account-heart</v-icon>
      </v-tab>
      <v-tab>
        タグフィード
        <v-icon>mdi-tag</v-icon>
      </v-tab>
      <v-tab-item>
        <NewPosts/>
      </v-tab-item>
      <v-tab-item>
        <FollowingUsers/>
      </v-tab-item>
      <v-tab-item>
        <FollowingTags/>
      </v-tab-item>
    </v-tabs>
  </v-card>
</template>
<script>
import NewPosts from '~/components/organisms/feeds/microposts/NewPosts.vue'
import FollowingUsers from '~/components/organisms/feeds/microposts/FollowingUsers.vue'
import FollowingTags from '~/components/organisms/feeds/microposts/FollowingTags.vue'
export default {
  components: {
    NewPosts,
    FollowingUsers,
    FollowingTags
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