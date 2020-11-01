<template>
  <v-card class="mx-auto mt-5 pa-5" width="700px">
    <v-card-text>
      <p>{{ userData }}さん</p>
      <v-avatar
        v-if="userData.avatar_url"
        size="62"
      >
        <img
          :src="userData.avatar_url"
          alt="Avatar"
        >
      </v-avatar>
    </v-card-text>
  </v-card>
</template>
<script>
import { mapMutations } from 'vuex'
export default {
  data () {
    return {
    }
  },
  async asyncData({ $axios, params, store, redirect }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const data = await $axios.$get(baseUrl + `/v1/users/${params.id}`)
      .catch((error) => {
        if (error.response.status === 404) {
          // とりあえずエラーページを実装。改修予定。
          return redirect('/error/404')
        }
        return false
      })
    return { userData: data }
  }
}
</script>
<style>

</style>