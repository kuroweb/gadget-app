<template>
  <v-card
    class="mx-auto mt-5 pa-3"
    :to="`/users/${user.id}`"
  >
    <v-row justify="center">
      <v-col cols="6">
        <v-avatar size="64">
          <img
            v-if="user.avatar_url"
            :src="user.avatar_url"
            alt="Avatar"
          />
          <img
            v-else
            src="~/assets/images/default_icon.jpeg"
            alt="Avatar"
          />
        </v-avatar>
      </v-col>
      <v-col cols="6">
        <h3>{{ user.name }}</h3>
      </v-col>
    </v-row>
  </v-card>
</template>
<script>
export default {
  props: {
    user: {
      type: Object
    }
  }
}
</script>