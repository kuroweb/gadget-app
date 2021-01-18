<template>
  <v-dialog
    v-model="previewStatus"
    persistent
    max-width="500"
    @click:outside="closePreview"
  >
    <v-card

      v-if="previewStatus"
    >
      <v-toolbar
        class="cyan darken-1"
        flat
      >
        <v-toolbar-title
          class="white--text font-weight-bold"
        >
          画像
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-icon
          dark
          @click="closePreview"
        >
          mdi-close
        </v-icon>
      </v-toolbar>
      <v-carousel
        v-model="selectImageNum"
        hide-delimiters
      >
        <v-carousel-item
          v-for="image in images"
          :key="image.id"
        >
          <v-img
            :src="image"
            contain
          >
          </v-img>
        </v-carousel-item>
      </v-carousel>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: {
    preview: {
      type: Boolean,
      required: true
    },
    images: {
      type: Array
    },
    selectImage: {
      type: Number
    }
  },
  data () {
    return {
      previewStatus: this.preview,
      selectImageNum: this.selectImage
    }
  },
  watch: {
    preview (newValue) {
      this.previewStatus = newValue
    },
    selectImage (newValue) {
      this.selectImageNum = newValue
    }
  },
  methods: {
    closePreview () {
      this.$emit('closePreview')
    }
  }
}
</script>