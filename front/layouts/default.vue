<template>
  <v-app style="background-color: #ECEFF1;">
    <Header/>
    <v-main>
      <v-container>
        <nuxt />
      </v-container>
    </v-main>
    <Footer/>
  </v-app>
</template>
<script>
import Header from '../components/organisms/Header.vue'
import Footer from '../components/organisms/Footer.vue'
export default {
  components: {
    Header,
    Footer,
  }
}
</script>
<style>

</style>