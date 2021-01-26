<template>
  <v-container>
    <div id="welcome" v-if="!$store.state.modules.user.data">
      <h1 id="welcome-title">ガジェコミ！</h1>
      <p id="welcome-subtitle">
        ガジェコミ！はガジェット好きが集まるSNSアプリです。
      </p>
      <GuestLogginButton/>
    </div>
    <v-row justify="center" :style="feed">
      <v-col xl="2" lg="3" sm="8" cols="12">
        <SideMenu
          @openMicropostFeed="openMicropostFeed"
          @openBoardList="openBoardList"
          @openGadgetList="openGadgetList"
        />
      </v-col>
      <v-col xl="5" lg="7" sm="8" cols="12">
        <MicropostFeed
          :render="micropostFeed"
        />
        <BoardFeed
          :render="boardList"
        />
        <GadgetFeed
          :render="gadgetList"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import MicropostFeed from '~/components/organisms/feeds/MicropostFeed.vue'
import BoardList from '~/components/organisms/feeds/BoardFeed.vue'
import GadgetList from '~/components/organisms/feeds/GadgetFeed.vue'
import SideMenu from '~/components/organisms/feeds/SideMenu.vue'
import GuestLogginButton from '~/components/organisms/GuestLogginButton.vue'
export default {
  components: {
    MicropostFeed,
    BoardList,
    GadgetList,
    SideMenu,
    GuestLogginButton
  },
  data () {
    return {
      micropostFeed: true,
      boardList: false,
      gadgetList: false
    }
  },
  computed: {
    feed () {
      if (this.$store.state.modules.user.data) {
        return ''
      } else {
        return 'margin-top: 250px;'
      }
    }
  },
  methods: {
    // メインコンテンツ表示切り替え関連
    openMicropostFeed () {
      this.micropostFeed = true
      this.boardList = false
      this.gadgetList = false
    },
    openBoardList () {
      this.micropostFeed = false
      this.boardList = true
      this.gadgetList = false
    },
    openGadgetList () {
      this.micropostFeed = false
      this.boardList = false
      this.gadgetList = true
    }
  }
}
</script>
<style scoped>
#welcome {
  background-color: #00ACC1;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 250px;
  color: white;
  text-align: center;
}

#welcome-title {
  margin-top: 40px;
  font-size: 2.4em;
}
</style>
