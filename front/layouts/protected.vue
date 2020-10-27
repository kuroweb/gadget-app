<template>
  <v-app style="background-color: #ECEFF1;">
    <Header/>
    <v-main>
      <v-container>
        <div>
          <nuxt-link to="/">Home</nuxt-link>
          <a href='#' @click="signout">Logout</a>
        </div>
      </v-container>
    </v-main>
    <Footer/>
  </v-app>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    middleware: 'authenticated',
    methods: {
      ...mapActions('modules/user', [ 'logout' ]),
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
