<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="2" lg="3" sm="8" cols="12">
        <SideMenu
          @openMicropostFeed="openMicropostFeed"
          @openBoardList="openBoardList"
          @openGadgetList="openGadgetList"
        />
      </v-col>
      <!-- メニュークリックに併せて表示内容を切り替え -->
      <v-col xl="4" lg="6" sm="8" cols="12">
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
      <v-col xl="2" lg="3" sm="8" cols="12">
        <v-card>
          <v-list>
            <v-subheader>ランキング</v-subheader>
          </v-list>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import MicropostFeed from '~/components/organisms/feeds/MicropostFeed.vue'
import BoardList from '~/components/organisms/feeds/BoardFeed.vue'
import GadgetList from '~/components/organisms/feeds/GadgetFeed.vue'
import SideMenu from '~/components/organisms/feeds/SideMenu.vue'
export default {
  components: {
    MicropostFeed,
    BoardList,
    GadgetList,
    SideMenu
  },
  data () {
    return {
      micropostFeed: true,
      boardList: false,
      gadgetList: false
    }
  },
  computed: {
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
</style>
