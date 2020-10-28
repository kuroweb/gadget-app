<template>
  <p>{{ userData }}ユーザー詳細ページ</p>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
  data () {
    return {
    }
  },
  computed: {
    ...mapGetters({
      uid: 'modules/user/uid'
    })
  },
  async asyncData({ $axios }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    const data = await $axios.$get(baseUrl + "/v1/users")
    return {
      userData: data
    }
  }
}
</script>
<style>

</style>