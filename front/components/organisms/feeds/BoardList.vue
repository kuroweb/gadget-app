<template>
  <v-card
    v-if="renderStatus"
  >
    <v-tabs
      centered
    >
      <v-tab>新着順</v-tab>
      <v-tab>雑談板</v-tab>
      <v-tab>質問板</v-tab>
      <v-tab-item>
        <p>新着順</p>
      </v-tab-item>
      <v-tab-item>
        <p>雑談板</p>
      </v-tab-item>
      <v-tab-item>
        <p>質問板</p>
      </v-tab-item>
    </v-tabs>
  </v-card>
</template>
<script>
export default {
  props: {
    render: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      renderStatus: this.render
    }
  },
  watch: {
    render (newValue) {
      this.renderStatus = newValue
    }
  }
}
</script>