<template>
  <v-container>
    <ErrorCard
      :display="!post"
      title="404NotFount"
      message="投稿が存在しません。"
    >
    </ErrorCard>
    <v-card v-if="post" class="mx-auto mt-5 pa-5" width="700px">
      <v-card-text>
        <v-row>
          <h3>タイトル</h3>
        </v-row>
        <v-row>
          <p>投稿内容</p>
        </v-row>
      </v-card-text>
    </v-card>
  </v-container>
</template>
<script>
import { mapGetters } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
export default {
  components: {
    ErrorCard
  },
  data () {
    return {
    }
  },
  async fetch({ $axios, params, store}) {
    try {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      const data = await $axios.$get(baseUrl + `/v1/posts/${params.id}`)
      store.commit('modules/post/setPOST', data)
    } catch (error) {
      console.log('投稿が存在しません。')
    }
  },
  computed: {
    ...mapGetters({
      post: 'modules/post/post'
    })
  }
}
</script>
<style>

</style>