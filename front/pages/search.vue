<template>
  <v-container>
    <v-card class="mx-auto" width="700px">
      <v-toolbar
        color="cyan darken-1"
        dark
        flat
      >
        <v-toolbar-title class="ml-3">
          検索ページ
        </v-toolbar-title>
      </v-toolbar>
      <v-tabs
        fixed-tabs
        centered
        background-color="cyan darken-1"
        color="white"
        slider-color="orange"
        icons-and-text
        show-arrows
      >
        <v-tab class="ma-0 pa-0">
          タグ
          <v-icon>
            mdi-tag
          </v-icon>
        </v-tab>
        <v-tab class="ma-0 pa-0">
          ユーザー
          <v-icon>
            mdi-account
          </v-icon>
        </v-tab>
        <v-tab class="ma-0 pa-0">
          投稿
          <v-icon>
            mdi-post
          </v-icon>
        </v-tab>
        <v-tab class="ma-0 pa-0">
          掲示板
          <v-icon>
            mdi-forum
          </v-icon>
        </v-tab>
        <v-tab-item>
          <v-card flat>
            <SearchTags/>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <SearchUsers/>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <SearchPosts/>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <p>掲示板</p>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </v-container>
</template>
<script>
import SearchPosts from '~/components/organisms/search/SearchPosts.vue'
import SearchUsers from '~/components/organisms/search/SearchUsers.vue'
import SearchTags from '~/components/organisms/search/SearchTags.vue'
import _ from 'lodash'
export default {
  components: {
    SearchTags,
    SearchUsers,
    SearchPosts
  },
}
</script>
<style scoped>

</style>