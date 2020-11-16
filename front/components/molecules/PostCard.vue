<template>
  <v-card
  class="mx-auto mt-5 pa-5"
  width="600px"
  >
    <v-card-title>
      <v-row justify="center">
        <v-col>
          <v-avatar 
          size="62"
          >
            <img
              src="~/assets/images/default_icon.jpeg"
              alt="Avatar"
            >
          </v-avatar>
        </v-col>
        <v-col>
          <h3>名前</h3>
        </v-col>
      </v-row>
    </v-card-title>
    <v-card-text>
      <v-row justify="center">
        <p>投稿内容</p>
      </v-row>
      <v-row justify="center">
        <v-avatar 
        size="62"
        >
          <img
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
        <v-avatar 
        size="62"
        >
          <img
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
        <v-avatar 
        size="62"
        >
          <img
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
        <v-avatar 
        size="62"
        >
          <img
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          >
        </v-avatar>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
  }
}
</script>
