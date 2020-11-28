<template>
  <v-app style="background-color: #ECEFF1;">
    <Flash/>
    <Loading
      v-if="loading"
    />
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
import { mapActions, mapGetters } from 'vuex'
import Header from '../components/organisms/Header.vue'
import Footer from '../components/organisms/Footer.vue'
import Loading from '../components/atoms/Loading.vue'
import Flash from '../components/atoms/Flash.vue'

export default {
  middleware: 'authenticated',
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
  },
  methods: {
    ...mapActions({
      logout: 'modules/user/logout'
    }),
    async signout () {
      await this.logout()
      this.$router.push('/')

      // this.logout().then(() => {
      //   this.$router.push('/')
      // }).catch((error) => {
      //   console.log(error.message)
      // })
    }
  }
}
</script>

<style>
  a {
    padding: 5px;
  }
</style>
