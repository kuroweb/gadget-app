<template>
  <v-footer color="cyan darken-2" dark>
    <v-row justify="center" class="text-center" dense>
      <v-col cols="12">
        <n-link to="/about" class="no-link">使い方はこちら</n-link>
      </v-col>
      <v-col cols="12">
        © 2021 gadget-community All Rights Reserved.
      </v-col>
    </v-row>
  </v-footer> 
</template>
  
<script>
export default {
  
}
</script>
  
<style scoped>
.no-link {
  color: inherit;
  text-decoration: none;
}
</style>