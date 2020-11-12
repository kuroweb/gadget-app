<template>
  <v-card>
    <div class="#">
      <ValidationObserver>
        <v-list-item
          v-for="n in maxImageNum"
          :key="n.id"
        >
          <ValidationProvider
            name="画像"
            rules="size:100"
            v-slot="{ errors, valid }"
            vid="画像"
          >
            <v-avatar 
              v-if="$data['image' + n].length !== 0"
              size="62"
            >
              <img
                v-if="$data['image' + n + 'Url']"
                :src="$data['image' + n + 'Url']"
              />
            </v-avatar>
            <v-btn
              v-if="$data['image' + n].length !== 0"
              block
              color="success"
            >
              削除
            </v-btn>
            <v-file-input
              v-if="$data['image' + n].length === 0"
              accept="image/*"
              :error-messages="errors"
              :success="valid"
              v-model="$data['image' + n]"
              @change="addImage(n, errors)"
            />
          </ValidationProvider>
        </v-list-item>
      </ValidationObserver>
    </div>

  </v-card>
</template>

<script>
export default {
  data () {
    return {
      blank: [],
      maxImageNum: 4,
      image1:[],
      image2:[],
      image3:[],
      image4:[],
      image1Url:[],
      image2Url:[],
      image3Url:[],
      image4Url:[],
    }
  },

  methods: {
    addImage (n, errors) {
      console.log(this.$data['image' + n])
      const fr = new FileReader()
      const file = this.$data['image' + n]
      fr.readAsDataURL(file)
      fr.addEventListener('load', () => {
        this.$data['image' + n + 'Url'] = fr.result
      })
    }
  }
}
</script>
<style>

</style>