<template>
  <ValidationProvider
    :name="$attrs.label"
    :rules="rules"
    v-slot="{ errors, valid }"
    :vid="$attrs.label"
  >
    <v-select
      v-model="inputValue"
      :items="items"
      :error-message="errors"
      :success="valid"
      v-bind="$attrs"
      v-on="$listeners"
    >
    </v-select>
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
    items: Array
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