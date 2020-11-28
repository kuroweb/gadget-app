<template>
  <v-app style="background-color: #ECEFF1;">
    <Flash />
    <Loading
      v-if="loading"
    />
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
import { mapGetters } from 'vuex'
import Header from '../components/organisms/Header.vue'
import Footer from '../components/organisms/Footer.vue'
import Loading from '../components/atoms/Loading.vue'
import Flash from '../components/atoms/Flash.vue'

export default {
  name: "default",

  components: {
    Header,
    Footer,
    Loading,
    Flash,
  },
  computed: {
    ...mapGetters({
      loading: 'modules/info/loading'
    })
  }
}
</script>
<style>

</style>