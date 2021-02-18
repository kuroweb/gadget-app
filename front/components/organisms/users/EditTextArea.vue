<template>
  <ValidationObserver>
    <v-row>
      <v-col>
        <v-icon v-if="icon">{{ icon }}</v-icon>
        <span class="input-label">{{ label }}</span>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <TextAreaWithValidation
        v-model="inputValue"
        :rules="rules"
        :label="label"
        />
      </v-col>
      <p v-if="error" class="errors">{{ error }}</p>
    </v-row>
  </ValidationObserver>
</template>
<script>
import TextAreaWithValidation from '~/components/molecules/inputs/TextAreaWithValidation.vue'
export default {
  components: {
    TextAreaWithValidation
  },
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    label: {
      type: String,
      required: true
    },
    icon: {
      type: String
    },
    value: {
      type: null
    },
    error: {
      type: String
    }
  },
  data() {
    return {
  
    }
  },
  computed: {
    inputValue: {
      get() {
        return this.value;
      },
      set(value) {
        this.$emit("input", value);
      }
    }
  },
}
</script>
<style scoped>

</style>