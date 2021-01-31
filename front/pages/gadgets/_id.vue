<template>
  <v-container>
    <ErrorCard
      :display="error"
      title="404NotFound"
      message="ガジェットが存在しません。"
    />
    <EditGadgetDialog
      :dialog="editGadgetDialog"
      :gadgetId="gadgetId"
      @editGadget="editGadget"
      @closeDialog="editGadgetDialog = false"
    />
    <DeleteGadgetDialog
      :dialog="deleteGadgetDialog"
      :gadgetId="gadgetId"
      :deletemode="deletemode"
      @deleteGadget="deleteGadget"
      @closeDialog="deleteGadgetDialog = false"
    />
    <v-row justify="center">
      <v-col lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>{{ gadget.title }}の詳細ページ</v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-card
              class="mx-auto"
              flat
            >
              <v-card-title>
                <ImagesV2
                  :images="gadget.images_url"
                />
              </v-card-title>
              <v-card-title>
                <Tags
                  :tags="gadget.tags"
                />
              </v-card-title>
              <v-card-actions>
                <v-row>
                  <v-col cols="12">
                    <h4>お気に入りポイント</h4>
                  </v-col>
                  <v-col cols="12">
                    <span>{{ gadget.good_description }}</span>
                  </v-col>
                  <v-col cols="12">
                    <h4>気になるポイント</h4>
                  </v-col>
                  <v-col cols="12">
                    <span>{{ gadget.bad_description }}</span>
                  </v-col>
                </v-row>
              </v-card-actions>
              <v-card-actions>
                <v-spacer/>
                持ち主：
                <v-avatar 
                size="24"
                >
                  <img 
                    v-if="gadget.user.avatar_url"
                    :src="gadget.user.avatar_url"
                    alt="Avatar"
                  >
                  <img
                    v-else
                    src="~/assets/images/default_icon.jpeg"
                    alt="Avatar"
                  >
                </v-avatar>
                <span>{{ gadget.user.name }}さん</span>
              </v-card-actions>
              <v-card-actions>
                <v-spacer/>
                満足度：
                <v-rating
                  dense
                  background-color="orange lighten-3"
                  color="orange"
                  length="5"
                  size="18"
                  readonly
                  :value="gadget.stars"
                />
              </v-card-actions>
              <v-card-actions>
                <v-spacer/>
                <!---------------->
                <!-- 管理メニュー -->
                <!---------------->
                <div v-if="$store.state.modules.user.data">
                  <!-- adminユーザーの場合 -->
                  <div v-if="$store.state.modules.user.data.admin === true">
                    <!-- 自身が作成したコンテンツの場合 -->
                    <div v-if="$store.state.modules.user.data.id === gadget.user.id">
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openEditGadgetDialog"
                      >
                        <v-icon>
                          mdi-pencil-box-multiple
                        </v-icon>
                      </v-btn>
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openDeleteGadgetDialog(mode.owner)"
                      >
                        <v-icon>
                          mdi-delete
                        </v-icon>
                      </v-btn>
                    </div>
                    <div v-else>
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openDeleteGadgetDialog(mode.admin)"
                      >
                        <v-icon>
                          mdi-delete
                        </v-icon>
                      </v-btn>
                    </div>
                  </div>
                  <!-- 一般ユーザーの場合 -->
                  <div v-if="$store.state.modules.user.data.admin === false">
                    <!-- 自身が作成したコンテンツの場合 -->
                    <div v-if="$store.state.modules.user.data.id === gadget.user.id">
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openEditGadgetDialog"
                      >
                        <v-icon>
                          mdi-pencil-box-multiple
                        </v-icon>
                      </v-btn>
                      <v-btn
                        icon
                        text
                        color="grey darken-2"
                        @click="openDeleteGadgetDialog(mode.owner)"
                      >
                        <v-icon>
                          mdi-delete
                        </v-icon>
                      </v-btn>
                    </div>
                  </div>
                </div>
              </v-card-actions>
            </v-card>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import ErrorCard from '~/components/molecules/ErrorCard.vue'
import Tags from '~/components/atoms/Tags.vue'
import ImagesV2 from '~/components/atoms/ImagesV2.vue'
import EditGadgetDialog from '~/components/organisms/gadgets/EditGadgetDialog.vue'
import DeleteGadgetDialog from '~/components/organisms/gadgets/DeleteGadgetDialog.vue'
export default {
  components: {
    ErrorCard,
    Tags,
    ImagesV2,
    EditGadgetDialog,
    DeleteGadgetDialog
  },
  data () {
    return {
      gadgetId: '',
      editGadgetDialog: false,
      deleteGadgetDialog: false,
      mode: {
        owner: 'owner',
        admin: 'admin'
      },
      deletemode: ''
    }
  },
  async fetch ({ $axios, params, store }) {
    const baseUrl = process.client ? process.env.BROWSER_BASE_URL : process.env.API_BASE_URL
    await $axios.$get(baseUrl + `/v1/gadgets/${params.id}`)
      .then(res => {
        store.dispatch('modules/gadget/setData', res)
        store.dispatch('modules/info/setError', false)
      })
      .catch(error => {
        store.dispatch('modules/info/setError', true)
      })
  },


  computed: {
    ...mapGetters({
      currentUser: 'modules/user/data',
      isAuthenticated: 'modules/user/isAuthenticated',
      gadget: 'modules/gadget/data',
      error: 'modules/info/error'
    })
  },

  methods: {
    ...mapActions({
      reloadGadgetByEditGadget: 'modules/gadget/reloadGadgetByEditGadget',
    }),
    openEditGadgetDialog () {
      this.gadgetId = this.gadget.id
      this.editGadgetDialog = true
    },
    openDeleteGadgetDialog (payload) {
      this.deletemode = payload
      this.gadgetId = this.gadget.id
      this.deleteGadgetDialog = true
    },
    editGadget (payload) {
      this.reloadGadgetByEditGadget(payload)
    },
    deleteGadget () {
      this.$router.push("/")
    }
  }
}
</script>