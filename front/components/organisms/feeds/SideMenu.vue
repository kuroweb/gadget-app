<template>
    <v-card>
      <v-toolbar
        color="cyan darken-1"
        dark
        flat
      >
        <v-toolbar-title>
          <v-icon class="mr-3">
            mdi-menu
          </v-icon>
          Menu
        </v-toolbar-title>
      </v-toolbar>
      <v-list>
        <v-list-item-group
          color="orange"
          mandatory
        >
          <v-list-item
            v-for="item in menuItems"
            :key="item.id"
            @click="menuClick(item.name)"
          >
            <v-list-item-content>
              <v-list-item-title>
                <v-icon class="mr-3">
                  {{ item.icon }}
                </v-icon>
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
          title: 'つぶやき',
          name: 'openMicropostFeed',
          icon: 'mdi-post-outline'
        },
        {
          title: '掲示板',
          name: 'openBoardList',
          icon: 'mdi-forum'
        },
        {
          title: 'みんなのガジェット',
          name: 'openGadgetList',
          icon: 'mdi-laptop'
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