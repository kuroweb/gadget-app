<template>
  <v-card flat>
    <v-card-title>
      タグ検索
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="tag"
        hint="タグ名を入力して検索"
      >
        <v-icon slot="prepend">mdi-magnify</v-icon>
      </v-text-field>
    </v-card-text>
    <v-card-text>
      <v-card
        class="mx-auto ma-5 pa-5"
        v-for="tag in tags"
        :key="tag.id"
      >
        <v-card-title>
          <Tag
            :tag="tag"
          />
        </v-card-title>
        <v-card-text>
          <div>投稿数：{{ tag.posts.length }}</div>
          <div>掲示板数：{{ tag.boards.length }}</div>
          <div>フォローしているユーザー数：{{ tag.users.length }}</div>
        </v-card-text>
        <v-card-actions>
          <v-btn
            block
            v-if="tag.isFollowed === false"
            @click="followTag(tag)"
            class="success"
          >
            <v-icon>
              mdi-tag
            </v-icon>
            フォローする
          </v-btn>
          <v-btn
            block
            v-if="tag.isFollowed === true"
            @click="unFollowTag(tag)"
            class="white--text"
            color="red"
          >
            <v-icon>
              mdi-tag
            </v-icon>
            フォロー解除
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-card-text>
  </v-card>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
import _ from 'lodash'
import Tag from '~/components/atoms/Tag.vue'
export default {
  components: {
    Tag
  },
  mounted () {
    this.resetTags()
  },
  data () {
    return {
      tag: ''
    }
  },
  watch: {
    tag () {
      this.delayFunc()
    }
  },
  computed: {
    ...mapGetters({
      tags: 'modules/tag/tags'
    })
  },
  methods: {
    ...mapActions({
      setTags: 'modules/tag/setTags',
      reloadTagsByFollow: 'modules/tag/reloadTagsByFollow',
      reloadTagsByUnFollow: 'modules/tag/reloadTagsByUnFollow',
      resetTags: 'modules/tag/resetTags'
    }),
    search () {
      const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
      this.$axios.$get(baseUrl + '/v1/tags/search', {
        params: {
          tag_name: this.tag
        }
      })
        .then(res => {
          this.setTags(res)
        })
        .catch(error => {
          console.log(error)
        })
    },
    followTag (tag) {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps', {
        follow_tag: {
          user_id: this.$store.state.modules.user.data.id,
          tag_id: tag.id
        }
      })
        .then(() => {
          this.reloadTagsByFollow(tag)
        })
    },
    unFollowTag (tag) {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps/delete', {
        params: {
          follow_tag: {
            user_id: this.$store.state.modules.user.data.id,
            tag_id: tag.id
          }
        }
      })
        .then(() => {
          this.reloadTagsByUnFollow(tag)
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