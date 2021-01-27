<template>
  <v-card flat>
    <SupportDialog
      :dialog="supportDialog"
      @closeDialog="supportDialog = false"
    />
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
          <div>ガジェット数：{{ tag.gadgets.length }}</div>
          <div>フォローしているユーザー数：{{ tag.users.length }}</div>
        </v-card-text>
        <v-card-actions v-if="$store.state.modules.user.data">
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
        <v-card-actions v-else>
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
import SupportDialog from '~/components/organisms/SupportDialog.vue'
export default {
  components: {
    Tag,
    SupportDialog
  },
  mounted () {
    this.resetTags()
  },
  data () {
    return {
      tag: '',
      supportDialog: false,
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
      if (this.$store.state.modules.user.data) {
        this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps', {
          follow_tag: {
            user_id: this.$store.state.modules.user.data.id,
            tag_id: tag.id
          }
        })
          .then(() => {
            this.reloadTagsByFollow(tag)
          })
      } else {
        this.openSupportDialog()
      }
    },
    unFollowTag (tag) {
      if (this.$store.state.modules.user.data) {
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
      } else {
        this.openSupportDialog()
      }
    },
    openSupportDialog () {
      this.supportDialog = true
    },
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  }
}
</script>
<style scoped>
</style>