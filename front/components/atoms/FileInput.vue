<template>
  <ValidationProvider
    :name="$attrs.label"
    :rules="rules"
    v-slot="{ errors, valid }"
    :vid="$attrs.label"
  >
    <v-row justify="center">
      <v-avatar
        v-if="uploadImageUrl"
        size="62"
      >
      <img
        :src="uploadImageUrl"
        alt="Avatar"
      >
      </v-avatar>
    </v-row>
    <v-file-input
      accept="image/*"
      label="File input"
      :error-messages="errors"
      :success="valid"
      v-bind="$attrs"
      v-on="$listeners"
      v-model="inputValue"
      @change="onImagePicked"
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
    }
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