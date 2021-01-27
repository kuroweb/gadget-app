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
        @change="changeNewPosts"
        class="ma-0 pa-0"
      >
        新着順
        <v-icon>mdi-clock-time-eight</v-icon>
      </v-tab>
      <v-tab
        @change="changeFollowingUsers"
        class="ma-0 pa-0"
      >
        タイムライン
        <v-icon>mdi-account-heart</v-icon>
      </v-tab>
      <v-tab
        @change="changeFollowingTags"
        class="ma-0 pa-0"
      >
        タグフィード
        <v-icon>mdi-tag</v-icon>
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab" touchless>
      <v-tab-item class="pa-1">
        <NewPosts
          :load="loadNewPosts"
        />
      </v-tab-item>
      <v-tab-item class="pa-1">
        <FollowingUsers
          v-if="$store.state.modules.user.data"
          :load="loadFollowingUsers"
        />
        <v-card flat v-else class="text-center">
          <span>ログインするとフォローユーザーのつぶやきを一覧表示します。</span>
        </v-card>
      </v-tab-item>
      <v-tab-item class="pa-1">
        <FollowingTags
          v-if="$store.state.modules.user.data"
          :load="loadFollowingTags"
        />
        <v-card flat v-else class="text-center">
          <span>ログインするとフォロータグを含むつぶやきを一覧表示します。</span>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>
<script>
import NewPosts from '~/components/organisms/feeds/micropostFeed/NewPosts.vue'
import FollowingUsers from '~/components/organisms/feeds/micropostFeed/FollowingUsers.vue'
import FollowingTags from '~/components/organisms/feeds/micropostFeed/FollowingTags.vue'
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
      loadNewPosts: false,
      loadFollowingUsers: false,
      loadFollowingTags: false,
      tab: null
    }
  },
  watch: {
    render (newValue) {
      this.renderStatus = newValue
    }
  },
  methods: {
    changeNewPosts () {
      this.loadNewPosts = !this.loadNewPosts
    },
    changeFollowingUsers () {
      this.loadFollowingUsers = !this.loadFollowingUsers
    },
    changeFollowingTags () {
      this.loadFollowingTags = !this.loadFollowingTags
    },
  }
}
</script>