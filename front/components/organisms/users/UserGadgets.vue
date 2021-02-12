<template>
  <v-container>
    <CreateGadgetDialog
      :dialog="createGadgetDialog"
      @createGadget="createGadget"
      @closeDialog="createGadgetDialog = false"
    />
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
        <v-row>
          <v-col cols="12">
            <v-btn
              block
              color="orange"
              dark
              rounded
              @click="openCreateGadgetDialog"
            >
              新しいガジェットを追加する
            </v-btn>
          </v-col>
          <v-col cols="12">
            <GadgetCard
              v-for="(gadget, index) in gadgets"
              :key="index"
              :gadget="gadget"
            />
            <VueInfiniteLoading
              ref="infiniteLoading"
              spinner="spiral"
              @infinite="infiniteHandler"
            >
              <span slot="no-more">-----ガジェットは以上です-----</span>
              <span slot="no-results"></span>
            </VueInfiniteLoading>
          </v-col>
          <v-col
            v-if="gadgets.length === 0 && loading === false"
            cols="12"
            class="text-center"
          >
            <span>登録されたガジェットがありません</span>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
import GadgetCard from '~/components/organisms/GadgetCard.vue'
import CreateGadgetDialog from '~/components/organisms/gadgets/CreateGadgetDialog.vue'
export default {
  components: {
    GadgetCard,
    CreateGadgetDialog
  },
  data () {
    return {
      loading: true,
      createGadgetDialog: false,
      count: 1
    }
  },
  props: {
    load: null
  },
  watch: {
    async load () {
      this.loading = true
      this.count = 1
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/gadgets`, {
        params: {
          user_id: this.$store.state.modules.otherUser.data.id,
          page: this.count
        }
      })
        .then(res => {
          this.setGadgets(res)
          setTimeout(this.stopLoading, 500)
        })
    }
  },
  async mounted () {
    this.count = 1
    await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/gadgets`, {
      params: {
        user_id: this.$store.state.modules.otherUser.data.id,
        page: this.count
      }
    })
      .then(res => {
        this.setGadgets(res)
        setTimeout(this.stopLoading, 500)
      })
  },
  computed: {
    ...mapGetters({
      gadgets: 'modules/gadget/gadgets'
    })
  },
  methods: {
    ...mapActions({
      setGadgets: 'modules/gadget/setGadgets',
      reloadGadgetsByCreateGadget: 'modules/gadget/reloadGadgetsByCreateGadget',
      reloadGadgetsByPageScrolling: 'modules/gadget/reloadGadgetsByPageScrolling'
    }),
    stopLoading () {
      this.loading = false
    },
    openCreateGadgetDialog () {
      this.createGadgetDialog = true
    },
    createGadget (payload) {
      this.reloadGadgetsByCreateGadget(payload)
    },
    async infiniteHandler () {
      this.count += 1
      await this.$axios.$get(process.env.BROWSER_BASE_URL + `/v1/gadgets`, {
        params: {
          user_id: this.$store.state.modules.otherUser.data.id,
          page: this.count
        }
      })
        .then(res => {
          if (res.length !== 0) {
            setTimeout(() => {
              this.reloadGadgetsByPageScrolling(res)
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