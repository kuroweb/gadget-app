<template>
  <ValidationProvider
    :name="$attrs.label"
    :rules="rules"
    v-slot="{ errors, valid }"
    :vid="$attrs.label"
  >
    <v-textarea
      label="プロフィール"
      counter
      rows="10"
      v-model="inputValue"
      :error-messages="errors"
      :success="valid"
      v-bind="$attrs"
      v-on="$listeners"
    >
    </v-textarea>
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
}
</script>
<style>

</style>