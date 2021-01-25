<template>
  <v-tooltip bottom max-width="250px">
    <template v-slot:activator="{ on, attrs }">
      <v-icon
      v-bind="attrs"
      v-on="on"
      >mdi-help-circle</v-icon>
    </template>
    <span>{{ explanation }}</span>
  </v-tooltip>
</template>

<script>
export default {
  props: {
    explanation: {
      type: String,
      required: true
    }
  }
}
</script>