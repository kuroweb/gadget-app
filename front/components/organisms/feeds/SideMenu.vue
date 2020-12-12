<template>
    <v-card>
      <v-list>
        <v-subheader>MENU</v-subheader>
        <v-divider class="my-2"></v-divider>
        <v-list-item-group color="primary">
          <v-list-item
            v-for="item in menuItems"
            :key="item.id"
            @click="menuClick(item.name)"
          >
            <v-list-item-content>
              <v-list-item-title>
                {{ item.title }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-card>
</template>
<script>
export default {
  data () {
    return {
      menuItems: [
        {
          title: 'マイクロポスト',
          name: 'openMicropostFeed'
        },
        {
          title: '掲示板',
          name: 'openBoardList'
        },
        {
          title: 'ガジェット',
          name: 'openGadgetList'
        }
      ]
    }
  },
  methods: {
    menuClick (name) {
      this.$emit(`${name}`)
    }
  }
}
</script>