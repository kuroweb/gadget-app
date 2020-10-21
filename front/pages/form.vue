<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }" immediate>
    <form>
      <ValidationProvider v-slot="{ errors, valid }" name="AWSアカウントID" rules="required|awsAccountId">
        <v-text-field
          v-model="awsAccountId"
          :error-messages="errors"
          label="AWSアカウントID"
          required
          :success="valid"
        ></v-text-field>
      </ValidationProvider>

      <ValidationProvider v-slot="{ errors, valid }" name="バケット名" rules="required|bucketName">
        <v-text-field
          v-model="bucketName"
          :error-messages="errors"
          label="バケット名"
          required
          :success="valid"
        ></v-text-field>
      </ValidationProvider>

      <v-btn class="mr-4" @click="submit" :disabled="invalid" color="success">submit</v-btn>
    </form>
  </ValidationObserver>
</template>

<script>
import { required } from 'vee-validate/dist/rules';
import { localize, extend, ValidationObserver, ValidationProvider } from 'vee-validate';
import ja from 'vee-validate/dist/locale/ja.json';
extend('required', required);
extend('awsAccountId', (value) => {
  return /^[0-9]{12}$/.test(value) || '{_field_} は12桁の数値です';
});
extend('bucketName', (value) => {
  return /^[a-z0-9.-]{3,63}$/.test(value) || '{_field_} のフォーマットが正しくありません';
});
localize('ja', ja);
export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data: () => ({
    awsAccountId: '',
    bucketName: '',
  }),
  methods: {
    submit () {
      this.$refs.observer.validate().then(result => {
        console.log('submit', result);
      });
    },
  },
}
</script>