<template>
  <v-card-text>
    <v-text-field
      v-model="user"
      hint="ユーザー名を入力して検索"
    >
      <v-icon slot="prepend">mdi-magnify</v-icon>
    </v-text-field>
    <v-row
      v-for="user in user_result"
      :key="user.id"
    >
      <p>{{ user.name }}</p>
    </v-row>
  </v-card-text>
</template>
<script>
import _ from 'lodash'
export default {
  data () {
    return {
      user: '',
      user_result: []
    }
  },
  watch: {
    user () {
      this.delayFunc()
    }
  },
  methods: {
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/users/search', {
        params: {
          user_name: this.user
        }
      })
        .then(res => {
          this.user_result = res
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  }
}
</script>
<style>

</style>