<template>
  <v-row justify="start">
      <v-chip
        v-for="tag in tags"
        :key="tag.id"
        class="ma-2"
        color="orange"
        label
        text-color="white"
      >
        <v-icon left>
          mdi-label
        </v-icon>
        {{ tag.tag_name }}
      </v-chip>
  </v-row>

</template>
<script>
export default {
  props: {
    tags: {
      type: Array
    }
  }
}
</script>