<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>
              <v-icon>
                mdi-bell-outline
              </v-icon>
              <span>通知一覧</span>
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col cols="12" v-if="loading">
                <v-skeleton-loader
                  class="mx-auto"
                  type="card"
                  v-for="n in 5"
                  :key="n.id"
                />
              </v-col>
              <v-col cols="12" v-if="loading === false">
                <v-row
                  dense
                  v-for="(notice, index) in notices"
                  :key="index"
                >
                  <v-col cols="12">
                    <v-card
                      flat
                      :to="notice.noticeLink"
                    >
                      <v-card-text>
                        <v-row>
                          <v-col>
                            <v-avatar size="25">
                              <img
                                v-if="notice.visitor.avatar_url !== null"
                                :src="notice.visitor.avatar_url"
                                alt="Avatar"
                              />
                              <img
                                v-else
                                src="~/assets/images/default_icon.jpeg"
                                alt="Avatar"
                              />
                            </v-avatar>
                            <span>{{ notice.noticeVisitor }}</span>
                            <span>{{ notice.noticeAction }}</span>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col>
                            <span>{{ notice.noticeTime }}</span>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-card>
                  </v-col>
                  <v-col cols="12">
                    <v-divider></v-divider>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col>
                    <VueInfiniteLoading
                      ref="infiniteLoading"
                      spinner="spiral"
                      @infinite="infiniteHandler"
                    >
                      <span slot="no-more">-----通知は以上です-----</span>
                      <span slot="no-results"></span>
                    </VueInfiniteLoading>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col
                    v-if="notices.length === 0"
                    cols="12"
                    class="text-center"
                  >
                    <span>通知がありません</span>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      loading: true,
      notices: [],
      count: 1
    }
  },
  async asyncData({ $axios, store, $moment }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    return $axios.$get(baseUrl + '/v1/notices', {
      params: {
        user_id: store.state.modules.user.data.id
      }
    })
      .then(res => {
        res.forEach(n => {
          switch (n.action) {
            case ('like'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = 'あなたの投稿にいいねしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('post_comment'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = 'あなたの投稿にコメントしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('post_comments'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = '投稿にコメントしました'
              n.noticeLink = `/posts/${n.post.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('board_comment'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = 'あなたが作成した掲示板にコメントしました'
              n.noticeLink = `/boards/${n.board.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('board_comments'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = '掲示板にコメントしました'
              n.noticeLink = `/boards/${n.board.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
            case ('follow'):
              n.noticeVisitor = `${n.visitor.name}さんが`
              n.noticeAction = 'あなたをフォローしました'
              n.noticeLink = `/users/${n.visitor.id}`
              n.noticeTime = $moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
              break
          }
        })
        return {
          notices: res,
        }
      })
  },
  mounted () {
    this.loading = false
  },
  methods: {
    async infiniteHandler () {
      this.count += 1
      await this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/notices', {
        params: {
          user_id: this.$store.state.modules.user.data.id,
          page: this.count
        }
      })
        .then(res => {
          if (res.length !== 0) {
            setTimeout(() => {
              res.forEach(n => {
                switch (n.action) {
                  case ('like'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = 'あなたの投稿にいいねしました'
                    n.noticeLink = `/posts/${n.post.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                  case ('post_comment'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = 'あなたの投稿にコメントしました'
                    n.noticeLink = `/posts/${n.post.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                  case ('post_comments'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = '投稿にコメントしました'
                    n.noticeLink = `/posts/${n.post.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                  case ('board_comment'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = 'あなたが作成した掲示板にコメントしました'
                    n.noticeLink = `/boards/${n.board.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                  case ('board_comments'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = '掲示板にコメントしました'
                    n.noticeLink = `/boards/${n.board.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                  case ('follow'):
                    n.noticeVisitor = `${n.visitor.name}さんが`
                    n.noticeAction = 'あなたをフォローしました'
                    n.noticeLink = `/users/${n.visitor.id}`
                    n.noticeTime = this.$moment(n.created_at).format('YYYY年MM月DD日 HH時mm分')
                    break
                }
              })
              res.forEach(r => {
                this.notices.push(r)
              })
              this.$refs.infiniteLoading.stateChanger.loaded()
            }, 1000)
          } else {
            this.$refs.infiniteLoading.stateChanger.complete()
          }
        })
    }
  }
}
</script>

<style scoped>
</style>
