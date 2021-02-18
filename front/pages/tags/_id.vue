<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="タグが存在しません。"
    />
    <v-row justify="center">
      <v-col xl="7" lg="8" sm="10" cols="12">
        <v-card class="mx-auto">
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title class="ml-3">
              {{ tag.tag_name }} の詳細ページ
            </v-toolbar-title>
          </v-toolbar>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="cyan darken-1"
            color="white"
            slider-color="orange"
            icons-and-text
            show-arrows
          >
            <v-tab class="ma-0 pa-0">
              投稿
              <v-icon>mdi-post</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              掲示板
              <v-icon>mdi-forum</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              ユーザー
              <v-icon>mdi-account</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              ガジェット
              <v-icon>mdi-laptop</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items
            v-model="tab"
            touchless
          >
            <v-tab-item>
              <v-card flat>
                <v-card-actions v-if="$store.state.modules.user.data">
                  <v-container>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === false"
                      @click="followTag()"
                      class="success"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォローする
                    </v-btn>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === true"
                      @click="unFollowTag()"
                      class="white--text"
                      color="red"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォロー解除
                    </v-btn>
                  </v-container>
                </v-card-actions>
                <v-card-title>
                  <Tag
                    :tag="tag"
                  />
                  を含む投稿
                </v-card-title>
                <v-card-text>
                  <v-card
                    class="mx-auto ma-5 pa-5"
                    v-for="post in tag.posts"
                    :key="post.id"
                  >
                    <v-card-title>
                      <v-spacer/>
                      <v-avatar size="64">
                        <img
                          v-if="post.user.avatar_url"
                          :src="post.user.avatar_url"
                          alt="Avatar"
                        />
                        <img
                          v-else
                          src="~/assets/images/default_icon.jpeg"
                          alt="Avatar"
                        />
                      </v-avatar>
                      <v-spacer/>
                      <v-card flat :to="`/users/${post.user.id}`">
                        <span>{{ post.user.name }}</span>
                      </v-card>
                      <v-spacer/>
                    </v-card-title>
                    <v-card-text>
                      <Tags
                        :tags="post.tags"
                      />
                    </v-card-text>
                    <v-card-text>
                      <v-card flat :to="`/posts/${post.id}`">
                        <span>{{ post.description }}</span>
                      </v-card>
                    </v-card-text>
                    <v-card-text v-if="post.images_url">
                      <Images
                        :images="post.images_url"
                      />
                    </v-card-text>
                  </v-card>
                </v-card-text>
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <v-card-actions v-if="$store.state.modules.user.data">
                  <v-container>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === false"
                      @click="followTag()"
                      class="success"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォローする
                    </v-btn>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === true"
                      @click="unFollowTag()"
                      class="white--text"
                      color="red"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォロー解除
                    </v-btn>
                  </v-container>
                </v-card-actions>
                <v-card-title>
                  <Tag
                    :tag="tag"
                  />
                  を含む掲示板
                </v-card-title>
                <v-card-text>
                  <v-card
                    class="mx-auto ma-5 pa-5"
                    v-for="board in tag.boards"
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
                    <v-card-text v-if="board.images_url">
                      <Images
                        :images="board.images_url"
                      />
                    </v-card-text>
                  </v-card>
                </v-card-text>
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <v-card-actions v-if="$store.state.modules.user.data">
                  <v-container>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === false"
                      @click="followTag()"
                      class="success"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォローする
                    </v-btn>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === true"
                      @click="unFollowTag()"
                      class="white--text"
                      color="red"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォロー解除
                    </v-btn>
                  </v-container>
                </v-card-actions>
                <v-card-title>
                  <Tag
                    :tag="tag"
                  />
                  をフォロー済みのユーザー
                </v-card-title>
                <v-card-text>
                  <v-card
                    class="mx-auto ma-5 pa-5"
                    v-for="(user, index) in tag.users"
                    :key="index"
                  >
                    <v-card-title>
                      <v-spacer/>
                      <v-avatar size="64">
                        <img
                          v-if="user.avatar_url"
                          :src="user.avatar_url"
                          alt="Avatar"
                        />
                        <img
                          v-else
                          src="~/assets/images/default_icon.jpeg"
                          alt="Avatar"
                        />
                      </v-avatar>
                      <v-spacer/>
                      <v-card flat :to="`/users/${user.id}`">
                        <span>{{ user.name }}</span>
                      </v-card>
                      <v-spacer/>
                    </v-card-title>
                    <v-card-actions v-if="$store.state.modules.user.data && $store.state.modules.user.data.id !== user.id">
                      <v-btn
                        block
                        v-if="user.isFollowed === false"
                        @click="followUser(user)"
                        class="success"
                      >
                        <v-icon>
                          mdi-account
                        </v-icon>
                        フォローする
                      </v-btn>
                      <v-btn
                        block
                        v-if="user.isFollowed === true"
                        @click="unFollowUser(user)"
                        class="white--text"
                        color="red"
                      >
                        <v-icon>
                          mdi-account
                        </v-icon>
                        フォロー解除
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-card-text>
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <v-card-actions v-if="$store.state.modules.user.data">
                  <v-container>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === false"
                      @click="followTag()"
                      class="success"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォローする
                    </v-btn>
                    <v-btn
                      rounded
                      block
                      v-if="tag.isFollowed === true"
                      @click="unFollowTag()"
                      class="white--text"
                      color="red"
                    >
                      <v-icon>
                        mdi-tag
                      </v-icon>
                      フォロー解除
                    </v-btn>
                  </v-container>
                </v-card-actions>
                <v-card-title>
                  <Tag
                    :tag="tag"
                  />
                  を含むガジェット
                </v-card-title>
                <v-card-text>
                  <v-card
                    class="mx-auto ma-5 pa-5"
                    v-for="gadget in tag.gadgets"
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
                    <v-card-text v-if="gadget.images_url">
                      <Images
                        :images="gadget.images_url"
                      />
                    </v-card-text>
                  </v-card>
                </v-card-text>
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import Tag from '~/components/atoms/Tag.vue'
export default {
  components: {
    ErrorCard,
    Tag,
  },
  data () {
    return {
      tab: null
    }
  },
  async fetch ({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/tags/${params.id}`)
      .then(res => {
        store.dispatch('modules/tag/setData', res)
      })
      .catch(error => {
        console.log(error)
        console.log('エラー')
      })
  },
  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      error: 'modules/info/error',
      tag: 'modules/tag/data',
    })
  },
  methods: {
    ...mapActions({
      setTags: 'modules/tag/setTags',
      reloadTagByFollow: 'modules/tag/reloadTagByFollow',
      reloadTagByUnFollow: 'modules/tag/reloadTagByUnFollow'
    }),
    followTag () {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps', {
        follow_tag: {
          user_id: this.$store.state.modules.user.data.id,
          tag_id: this.tag.id,
          uid: this.$store.state.modules.user.user.uid
        }
      })
        .then(() => {
          this.reloadTagByFollow()
        })
    },
    unFollowTag () {
      this.$axios.$delete(process.env.BROWSER_BASE_URL + '/v1/user_tag_maps/delete', {
        params: {
          user_id: this.$store.state.modules.user.data.id,
          tag_id: this.tag.id,
          uid: this.$store.state.modules.user.user.uid
        }
      })
        .then(() => {
          this.reloadTagByUnFollow()
        })
    }
  }
}
</script>