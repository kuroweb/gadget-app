<template>
  <v-card
    class="mx-auto mt-5 pa-3"
    :to="`/users/${user.id}`"
  >
    <v-row>
      <v-col cols="12">
        <h3>{{ user.name }}</h3>
      </v-col>
      <v-col cols="12">
        <p>{{ $moment(user.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
      </v-col>
      <v-col cols="12" v-if="user.avatar_url">
        <v-row justify="center">
          <v-img
            :src="user.avatar_url"
            aspect-ratio="1"
          />
        </v-row>
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