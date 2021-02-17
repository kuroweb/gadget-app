<template>
  <v-card
    v-if="renderStatus"
  >
    <v-tabs
      v-model="tab"
      fixed-tabs
      centered
      background-color="cyan darken-1"
      color="white"
      slider-color="orange"
      icons-and-text
    >
      <v-tab
        class="ma-0 pa-0"
        @change="changeNewGadgets"
      >
        新着順
        <v-icon>mdi-clock-time-eight</v-icon>
      </v-tab>
      <v-tab
        class="ma-0 pa-0"
        @change="changeNewGadgets"
      >
        実装中
        <v-icon>mdi-forum</v-icon>
      </v-tab>
      <v-tab
        class="ma-0 pa-0"
        @change="changeNewGadgets"
      >
        実装中
        <v-icon>mdi-comment-question</v-icon>
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab" touchless>
      <v-tab-item class="pa-1">
        <NewGadgets
          :load="loadNewGadgets"
        />
      </v-tab-item>
      <v-tab-item class="pa-1">
        <NewGadgets
          :load="loadNewGadgets"
        />
      </v-tab-item>
      <v-tab-item class="pa-1">
        <NewGadgets
          :load="loadNewGadgets"
        />
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>
<script>
import NewGadgets from '~/components/organisms/feeds/gadgetFeed/NewGadgets.vue'
export default {
  components: {
    NewGadgets
  },
  props: {
    render: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      renderStatus: this.render,
      loadNewGadgets: false,
      tab: null
    }
  },
  watch: {
    render (newValue) {
      this.renderStatus = newValue
    }
  },
  methods: {
    changeNewGadgets () {
      this.loadNewGadgets = !this.loadNewGadgets
    }
  }
}
</script>