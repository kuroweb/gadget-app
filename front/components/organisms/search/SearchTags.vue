<template>
  <v-card-text>
    <v-text-field
      v-model="tag"
      hint="タグ名を入力して検索"
    >
      <v-icon slot="prepend">mdi-magnify</v-icon>
    </v-text-field>
    <v-row
      v-for="tag in tag_result"
      :key="tag.id"
    >
      <p>{{ tag.tag_name }}</p>
    </v-row>
  </v-card-text>
</template>
<script>
import _ from 'lodash'
export default {
  data () {
    return {
      tag: '',
      tag_result: []
    }
  },
  watch: {
    tag () {
      this.delayFunc()
    }
  },
  methods: {
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/tags/search', {
        params: {
          tag_name: this.tag
        }
      })
        .then(res => {
          this.tag_result = res
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