<template>
  <v-card
    class="mx-auto"
    flat
  >
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
    <v-divider></v-divider>
  </v-card>
</template>
<script>
import Tags from "~/components/atoms/Tags.vue"
import ImagesV2 from "~/components/atoms/Images_v2.vue"
export default {
  components: {
    ImagesV2,
    Tags
  },
  props: {
    gadget: {
      type: Object
    }
  },
}
</script>