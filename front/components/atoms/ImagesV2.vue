<template>
  <v-row>
    <PreviewImages
      :preview="preview"
      :images="images"
      :selectImage="selectImage"
      @closePreview="preview = false"
    />
    <v-col
      v-if="images"
    >
      <v-row v-if="images.length === 4">
        <v-col cols="8" class="pa-1">
          <v-img
            :src="images[0]"
            :aspect-ratio="4/3"
            @click="openPreview(0)"
          />
        </v-col>
        <v-col cols="4" class="pa-1" align-self="center">
          <v-row dense>
            <v-col cols="12">
              <v-img
                :src="images[1]"
                :aspect-ratio="16/7.5"
                @click="openPreview(1)"
              />
            </v-col>
            <v-col cols="12">
              <v-img
                :src="images[2]"
                :aspect-ratio="16/7.5"
                @click="openPreview(2)"
              />
            </v-col>
            <v-col cols="12">
              <v-img
                :src="images[3]"
                :aspect-ratio="16/7.5"
                @click="openPreview(3)"
              />
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <v-row v-if="images.length === 3">
        <v-col cols="7" class="pa-1">
          <v-img
            :src="images[0]"
            :aspect-ratio="4/3"
            @click="openPreview(0)"
          />
        </v-col>
        <v-col cols="5" class="pa-1" align-self="center">
          <v-row dense>
            <v-col cols="12">
              <v-img
                :src="images[1]"
                :aspect-ratio="16/8"
                @click="openPreview(1)"
              />
            </v-col>
            <v-col cols="12">
              <v-img
                :src="images[2]"
                :aspect-ratio="16/8"
                @click="openPreview(2)"
              />
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <v-row v-if="images.length === 2">
        <v-col cols="6" class="pa-1">
          <v-img
            :src="images[0]"
            :aspect-ratio="4/3"
            @click="openPreview(0)"
          />
        </v-col>
        <v-col cols="6" class="pa-1">
          <v-img
            :src="images[1]"
            :aspect-ratio="4/3"
            @click="openPreview(1)"
          />
        </v-col>
      </v-row>
      <v-row v-if="images.length === 1">
        <v-col cols="12" class="pa-1">
          <v-img
            :src="images[0]"
            :aspect-ratio="16/7"
            @click="openPreview(0)"
          />
        </v-col>
      </v-row>
    </v-col>
  </v-row>

</template>
<script>
import PreviewImages from '~/components/atoms/PreviewImages.vue'
export default {
  components: {
    PreviewImages,
  },
  props: {
    images: {
      type: Array
    }
  },
  data () {
    return {
      preview: false,
      selectImage: 0
    }
  },
  methods: {
    openPreview (index) {
      this.selectImage = index
      this.preview = true
    }
  }
}
</script>