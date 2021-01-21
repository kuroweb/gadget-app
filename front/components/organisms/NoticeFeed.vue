<template>
  <div class="mr-4">
    <v-menu
      v-model="noticeVal"
      :offset-y="true"
      :left="true"
      max-height="480"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-badge
          color="orange"
          :content="count"
          :value="count"
          overlap
        >
          <v-icon @click="openNoticeFeed" v-bind="attrs" v-on="on">
            mdi-bell-outline
          </v-icon>
        </v-badge>
      </template>
      <v-list subheader two-line width="300px">
        <v-card flat>
          <v-card-title>
            <v-icon>
              mdi-bell-outline  
            </v-icon>
              <span id="notice-title">通知</span>
            <v-spacer/>
            <v-card flat to="/notices">
              <span id="notice-sublink">通知一覧</span>
            </v-card>
          </v-card-title>
          <v-card-text v-for="notice in notices" :key="notice.id" >
            <v-card flat :to="notice.noticeLink">
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
                  {{ notice.noticeTime }}
                </v-col>
              </v-row>
            </v-card>
          </v-card-text>
        </v-card>
      </v-list>
    </v-menu>
  </div>
</template>
<script>
export default {
  data() {
    return {
      count: 0,
      noticeFeed: false,
      notices: [],
      noticeVal: false
    }
  },
  mounted () {
    this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/notices/unchecked', {
      params: {
        user_id: this.$store.state.modules.user.data.id
      }
    })
      .then(res => {
        this.count = res
      })
  },
  computed: {
  },
  methods: {
    openNoticeFeed () {
      if (this.noticeFeed === false) {
        this.$axios.$get(process.env.BROWSER_BASE_URL + '/v1/notices/checked', {
          params: {
            user_id: this.$store.state.modules.user.data.id
          }
        })
          .then(res => {
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
              }
            })
            this.notices = res
          })
      }
      this.noticeFeed = !this.noticeFeed
      this.count = 0
    }
  }
}
</script>
<style scoped>
#notice-title {
  font-size: 0.8em;
}
#notice-sublink {
  font-size: 0.6em;
}
</style>