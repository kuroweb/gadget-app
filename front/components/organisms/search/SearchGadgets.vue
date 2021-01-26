<template>
  <v-card flat>
    <v-card-title>
      ガジェット検索
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="gadget"
        hint="ガジェット名を入力して検索"
      >
        <v-icon slot="prepend">mdi-magnify</v-icon>
      </v-text-field>
    </v-card-text>
    <v-card-text>
      <v-card
        class="mx-auto ma-5 pa-5"
        v-for="gadget in gadget_result"
        :key="gadget.id"
      >
        <v-card-title>
          <v-spacer/>
          <v-avatar size="64">
            <img
              v-if="gadget.user.avatar_url"
              :src="gadget.user.avatar_url"
              alt="Avatar"
            />
            <img
              v-else
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            />
          </v-avatar>
          <v-spacer/>
          <v-card flat :to="`/users/${gadget.user.id}`">
            <span>{{ gadget.user.name }}</span>
          </v-card>
          <v-spacer/>
        </v-card-title>
        <v-card-text>
          <Tags
            :tags="gadget.tags"
          />
        </v-card-text>
        <v-card-text>
          <v-card flat :to="`/gadgets/${gadget.id}`">
            <span>{{ gadget.title }}</span>
          </v-card>
        </v-card-text>
        <v-card-text>
          <Images
            :images="gadget.images_url"
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
      gadget: '',
      gadget_result: []
    }
  },
  watch: {
    gadget () {
      this.delayFunc()
    }
  },
  methods: {
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/gadgets/search', {
        params: {
          gadget_name: this.gadget
        }
      })
        .then(res => {
          this.gadget_result = res
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