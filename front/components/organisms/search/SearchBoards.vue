<template>
  <v-card flat>
    <v-card-title>
      掲示板検索
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="board"
        hint="掲示板名を入力して検索"
      >
        <v-icon slot="prepend">mdi-magnify</v-icon>
      </v-text-field>
    </v-card-text>
    <v-card-text>
      <v-card
        class="mx-auto ma-5 pa-5"
        v-for="board in board_result"
        :key="board.id"
      >
        <v-card-title>
          <v-spacer/>
          <v-avatar size="64">
            <img
              v-if="board.user.avatar_url"
              :src="board.user.avatar_url"
              alt="Avatar"
            />
            <img
              v-else
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            />
          </v-avatar>
          <v-spacer/>
          <v-card flat :to="`/users/${board.user.id}`">
            <span>{{ board.user.name }}</span>
          </v-card>
          <v-spacer/>
        </v-card-title>
        <v-card-text>
          <Tags
            :tags="board.tags"
          />
        </v-card-text>
        <v-card-text>
          <v-card flat :to="`/boards/${board.id}`">
            <span>{{ board.description }}</span>
          </v-card>
        </v-card-text>
        <v-card-text>
          <Images
            :images="board.images_url"
          />
        </v-card-text>
      </v-card>
    </v-card-text>
  </v-card>
</template>
<script>
import _ from 'lodash'
import Tags from "~/components/atoms/Tags.vue"
import Images from "~/components/atoms/Images.vue"
import { mapGetters, mapActions } from 'vuex'
export default {
  components: {
    Tags,
    Images,
  },
  data () {
    return {
      board: '',
      board_result: []
    }
  },
  watch: {
    board () {
      this.delayFunc()
    }
  },
  methods: {
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/boards/search', {
        params: {
          board_name: this.board
        }
      })
        .then(res => {
          this.board_result = res
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
<style scoped>

</style>