<template>
  <v-row justify="center">
    <PreviewImages
      :preview="preview"
      :images="images"
      :selectImage="selectImage"
      @closePreview="preview = false"
    />
    <v-col
      lg="3" sm="3" cols="3"
      v-for="(image, index) in images"
      :key="index"
    >
      <v-img
        :src="image"
        aspect-ratio="1"
        @click="openPreview(index)"
      />
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