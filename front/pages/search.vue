<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="700px">
      <v-tabs
        centered
      >
        <v-tabs-slider></v-tabs-slider>
        <v-tab>タグ</v-tab>
        <v-tab>ユーザー</v-tab>
        <v-tab>投稿</v-tab>
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
<style>

</style>