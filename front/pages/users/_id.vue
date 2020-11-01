<template>
  <v-card class="mx-auto mt-5 pa-5" width="700px">
    <v-card-text>
      <v-row justify="center">
        <v-avatar 
        size="62"
        >
          <img 
            v-if="userData.avatar_url"
            :src="userData.avatar_url"
            alt="Avatar"
          >
          <img
            v-else
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
      </v-row>
      <v-row justify="center">
        <h3>{{ userData.name }} さん</h3>
      </v-row>
      <v-row justify="center">
        <p>{{ userData.profile }}</p>
      </v-row>
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