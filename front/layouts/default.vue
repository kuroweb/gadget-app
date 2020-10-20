<template>
　<v-app style="background-color: #ECEFF1;">
    <Header />
    <v-main>
      <v-container>
        <nuxt />
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Footer from '../components/organisms/Footer.vue'
import Header from '../components/organisms/Header.vue'
export default {
  components: {
    Header,
    Footer,
  }
}
</script>

<style>

</style>