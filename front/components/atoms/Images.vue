<template>
  <v-row justify="center">
    <v-col
      lg="3" sm="3" cols="3"
      v-for="image in images"
      :key="image.id"
    >
      <v-img
        :src="image"
        aspect-ratio="1"
      />
    </v-col>
  </v-row>

</template>
<script>
export default {
  props: {
    images: {
      type: Array
    }
  }
}
</script>