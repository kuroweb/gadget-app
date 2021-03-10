<template>
  <v-footer color="cyan darken-2" dark>
    <v-row justify="center" no-gutters>
      <v-col xl="6" lg="6" sm="6" cols="12" align-self="center" class="text-center white--text pt-2 bold">
        <v-card flat to="/" color="cyan darken-2" dark>
          <h1>ガジェコミ！</h1>
          <p>ガジェット好きが集まるSNSアプリ</p>
        </v-card>

      </v-col>
      <v-col xl="6" lg="6" sm="6" cols="12" align-self="center" class="text-center">
        <v-btn
          v-for="(item, index) in items"
          :key="index"
          :to="item.to"
          text
          rounded
        >
          <strong>{{item.title}}</strong>
        </v-btn>
        <v-btn
          v-for="(link, index) in links"
          :key="index"
          :href="link.to"
          text
          rounded
        >
          <strong>{{link.title}}</strong>
        </v-btn>
      </v-col>
      <v-col cols="12" class="pb-5">
        <v-divider></v-divider>
      </v-col>
      <v-col cols="12" align-self="center" class="text-center">
        <p>© 2021 gadget-community All Rights Reserved.</p>
      </v-col>
    </v-row>
  </v-footer> 
</template>
  
<script>
export default {
  data () {
    return {
    }
  },
  computed: {
    items() {
      const items = [
        {
          title: 'ガジェコミとは？',
          to: '/about'
        },
        {
          title: '利用規約',
          to: '/agreement'
        }
      ]
      return items
    },
    links() {
      const links = [
        {
          title: 'TWITTER',
          to: 'https://twitter.com/kuroweb_net'
        },
        {
          title: 'GITHUB',
          to: 'https://github.com/kuromitsu0104'
        }
      ]
      return links
    }
  }
}
</script>
  
<style scoped>
</style>