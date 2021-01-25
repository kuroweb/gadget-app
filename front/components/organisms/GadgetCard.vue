<template>
  <v-card
    class="mx-auto"
    flat
  >
    <DeleteGadgetDialog
      :dialog="deleteGadgetDialog"
      :gadgetId="gadgetId"
      @deleteGadget="deleteGadget"
      @closeDialog="deleteGadgetDialog = false"
    />
    <EditGadgetDialog
      :dialog="editGadgetDialog"
      :gadgetId="gadgetId"
      @editGadget="editGadget"
      @closeDialog="editGadgetDialog = false"
    />
    <v-card-text>
      <ImagesV2
        :images="gadget.images_url"
      />
    </v-card-text>
    <v-card-title>
      <v-card flat :to="`/gadgets/${gadget.id}`">
        <v-icon class="mr-3">mdi-laptop</v-icon>
        <span>{{ gadget.title }}</span>
      </v-card>
    </v-card-title>
    <v-card-text>
      <Tags
        :tags="gadget.tags"
      />
    </v-card-text>
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
              @click="openDeleteGadgetDialog"
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
              @click="openDeleteGadgetDialog"
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
              @click="openDeleteGadgetDialog"
            >
              <v-icon>
                mdi-delete
              </v-icon>
            </v-btn>
          </div>
        </div>
      </div>
    </v-card-actions>
    <v-divider></v-divider>
  </v-card>
</template>
<script>
import { mapActions } from 'vuex'
import DeleteGadgetDialog from '~/components/organisms/gadgets/DeleteGadgetDialog.vue'
import EditGadgetDialog from '~/components/organisms/gadgets/EditGadgetDialog.vue'
import Tags from "~/components/atoms/Tags.vue"
import ImagesV2 from "~/components/atoms/ImagesV2.vue"
export default {
  components: {
    DeleteGadgetDialog,
    EditGadgetDialog,
    ImagesV2,
    Tags
  },
  props: {
    gadget: {
      type: Object
    }
  },
  data () {
    return {
      editGadgetDialog: false,
      deleteGadgetDialog: false,
      gadgetId: ''
    }
  },
  methods: {
    ...mapActions({
      reloadGadgetsByEditGadget: 'modules/gadget/reloadGadgetsByEditGadget',
      reloadGadgetsByDeleteGadget: 'modules/gadget/reloadGadgetsByDeleteGadget',
    }),
    openDeleteGadgetDialog () {
      this.gadgetId = this.gadget.id
      this.deleteGadgetDialog = true
    },
    openEditGadgetDialog () {
      this.gadgetId = this.gadget.id
      this.editGadgetDialog = true
    },
    editGadget (payload) {
      this.reloadGadgetsByEditGadget(payload)
    },
    deleteGadget (payload) {
      this.reloadGadgetsByDeleteGadget(payload)
    },
  }
}
</script>