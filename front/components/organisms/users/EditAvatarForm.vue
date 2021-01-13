<template>
  <ValidationProvider
    :name="$attrs.label"
    :rules="rules"
    v-slot="{ errors, valid }"
    :vid="$attrs.label"
  >
    <div class="input-block">
      <v-row>
        <v-col>
          <v-icon v-if="icon">{{ icon }}</v-icon>
          <span class="input-label">{{ label }}</span>
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-avatar 
        size="62"
        >
          <img 
            v-if="uploadImageUrl"
            :src="uploadImageUrl"
            alt="Avatar"
          >
          <img 
            v-else-if="avatar_url"
            :src="avatar_url"
            alt="Avatar"
          >
          <img
            v-else
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
      </v-row>
      <v-row>
        <v-col>
          <v-file-input
            v-model="inputValue"
            accept="image/*"
            prepend-icon="mdi-image"
            @change="onImagePicked"
            :error-messages="errors"
            :success="valid"
            v-bind="$attrs"
            v-on="$listeners"
            placeholder="画像を選択してください"
          >
          </v-file-input>
        </v-col>
        <p v-if="error" class="errors">{{ error }}</p>
      </v-row>
    </div>
  </ValidationProvider>
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
    avatar_url: {
      type: null,
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
    }
  },
  data() {
    return {
      uploadImageUrl: ''
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
    }
  }
}
</script>
<style scoped>

</style>