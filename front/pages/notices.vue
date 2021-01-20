<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card class="mx-auto">
          <p>通知テスト</p>
          <p>{{ notices }}</p>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      notices: []
    }
  },
  async mounted() {
    this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/notices', {
      params: {
        user_id: this.$store.state.modules.user.data.id
      }
    })
      .then((res) => {
        this.notices = res
      })
  }
}
</script>

<style scoped>
</style>
