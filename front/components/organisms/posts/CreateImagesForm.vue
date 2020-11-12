<template>
  <div class="input-block">
    <v-container>
      <v-row>
        <v-icon
          v-if="uploadImageUrl !== empty"
          @click="removeImage"
          >
            mdi-close-thick
          </v-icon>
        <v-col>
          <v-icon v-if="icon">{{ icon }}</v-icon>
          <span class="input-label">{{ label }}</span>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-avatar 
          v-if="uploadImageUrl"
          size="62"
        >
          <img 
            :src="uploadImageUrl"
            alt="Images"
          >
        </v-avatar>
      </v-row>
      <v-row>
        <div class="input-box">
          <v-file-input
            v-if="inputValue.length === 0"
            v-model="inputValue"
            accept="image/*"
            prepend-icon="mdi-camera"
            @change="onImagePicked"
            hide-input
          >
          </v-file-input>
        </div>

      </v-row>
    </v-container>
  </div>
</template>
<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    value: {
      type: null
    },
    label: {
      type: String,
      required: true
    },
    icon: {
      type: String
    },
    error: {
      type: String
    },
  },
  data() {
    return {
      uploadImageUrl: '',
      empty: ''
    }
  },
  computed: {
    inputValue: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit("input", value)
      }
    }
  },
  methods: {
    onImagePicked(file) {
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.uploadImageUrl = fr.result
        })
      } else {
        this.uploadImageUrl = ''
      }
    },
    removeImage() {
      this.uploadImageUrl = '',
      this.$emit("input", [])
    }
  }
}
</script>
<style>
.input-box {
  padding: 0 30%;
}
</style>