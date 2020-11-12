<template>
  <v-container>
    <v-card>
      <v-container>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3
            align-self="center"
            v-for="n in maxImageNum"
            :key="n.id"
          >
            <v-row justify="center">
              <v-avatar
                justify="center"
                v-if="$data['image' + n].length !== 0"
                size="62"
              >
                <img
                  v-if="$data['image' + n + 'Url']"
                  :src="$data['image' + n + 'Url']"
                />
              </v-avatar>
            </v-row>
            <v-row justify="center">
              <v-btn
                v-if="$data['image' + n].length !== 0"
                color="success"
                @click="removeImage(n)"
              >
                削除
              </v-btn>
            </v-row>

            <div class="input-box">
              <v-file-input
                v-if="$data['image' + n].length === 0"
                accept="image/*"
                v-model="$data['image' + n]"
                @change="addImage(n)"
                prepend-icon="mdi-camera"
                label="File input"
                hide-input
              />
            </div>

          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
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
    addImage (n) {
      const file = this.$data['image' + n]
      if (file !== undefined && file !== null) {
        if (file.size > 1000000) {
          console.log('ファイルサイズが大きすぎます')
          this.$data['image' + n] = []
        }
        if (file.size <= 1000000) {
          const fr = new FileReader()
          fr.readAsDataURL(file)
          fr.addEventListener('load', () => {
            this.$data['image' + n + 'Url'] = fr.result
          })
        }
      } else {
        this.$data['image' + n + 'Url'] = []
      }
    },
    removeImage (n) {
      this.$data['image' + n + 'Url'] = []
      this.$data['image' + n] = []
    }
  }
}
</script>
<style>
.input-box {
  padding: 0 30%;
}
</style>