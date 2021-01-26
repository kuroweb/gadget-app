<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="7" lg="8" sm="10" cols="12">
        <v-card class="mx-auto">
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
            v-model="tab"
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
            <v-tab class="ma-0 pa-0">
              ガジェット
              <v-icon>
                mdi-laptop
              </v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items
            v-model="tab"
            touchless
          >
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
                <SearchBoards/>
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <SearchGadgets/>
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>

  </v-container>
</template>
<script>
import SearchPosts from '~/components/organisms/search/SearchPosts.vue'
import SearchBoards from '~/components/organisms/search/SearchBoards.vue'
import SearchGadgets from '~/components/organisms/search/SearchGadgets.vue'
import SearchUsers from '~/components/organisms/search/SearchUsers.vue'
import SearchTags from '~/components/organisms/search/SearchTags.vue'
import _ from 'lodash'
export default {
  components: {
    SearchTags,
    SearchUsers,
    SearchGadgets,
    SearchBoards,
    SearchPosts
  },
  data () {
    return {
      tab: null
    }
  }
}
</script>
<style scoped>

</style>