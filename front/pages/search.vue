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
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>ユーザー</p>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>投稿</p>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-card>
  </v-container>
</template>
<script>
import _ from 'lodash'
export default {
  data () {
    return {
      tag: '',
      tag_result: [],
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