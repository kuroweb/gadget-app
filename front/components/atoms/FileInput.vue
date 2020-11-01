<template>
  <ValidationProvider
    :name="$attrs.label"
    :rules="rules"
    v-slot="{ errors, valid }"
    :vid="$attrs.label"
  >
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
    <v-file-input
      v-model="inputValue"
      accept="image/*"
      label="File input"
      prepend-icon="mdi-image"
      @change="onImagePicked"
      :error-messages="errors"
      :success="valid"
      v-bind="$attrs"
      v-on="$listeners"
    >
    </v-file-input>
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
  },
  data() {
    return {
      avatar: [],
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
<style>

</style>