<template>
  <v-row>
    <v-col cols=3
      align-self="center"
      v-for="n in maxImageNum"
      :key="n.id"
    >
      <v-row justify="center">
        <v-avatar
          justify="center"
          v-if="$data['image' + n].length != 0"
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
          v-if="$data['image' + n].length != 0"
          color="red"
          class="white--text"
          @click="removeImage(n)"
        >
          削除
        </v-btn>
      </v-row>
      <div class="input-box">
        <v-file-input
          v-if="$data['image' + n].length == 0"
          accept="image/*"
          v-model="$data['image' + n]"
          @change="addImage(n)"
          prepend-icon="mdi-camera"
          hide-input
        />
      </div>
    </v-col>
    <p v-if="imageError">{{ imageError }}</p>
  </v-row>
</template>
<script>
export default {
  data () {
    return {
      maxImageNum: 4,
      image1Url: [],
      image2Url: [],
      image3Url: [],
      image4Url: [],
      image1: [],
      image2: [],
      image3: [],
      image4: [],
      imageError: null,
      images: []
    }
  },
  methods: {
    addImage (n) {
      const file = this.$data['image' + n]
      if (file !== undefined && file !== null) {
        if (file.size > 1000000) {
          console.log('ファイルサイズが大きすぎます')
          this.$data['image' + n] = []
          this.imageError = "画像のファイルサイズが1MBを超えています。"
        }
        if (file.size <= 1000000) {
          const fr = new FileReader()
          fr.readAsDataURL(file)
          fr.addEventListener('load', () => {
          this.$data['image' + n + 'Url'] = fr.result
          })
          this.imageError = null
          this.images = []
          for (let i = 1; i <= this.maxImageNum; i++) {
            if (this.$data['image' + i].length !== 0) {
              this.images.push(this.$data['image' + i])
            }
          }
          this.$emit('setImages', this.images)
        }
      } else {
        this.$data['image' + n + 'Url'] = []
        this.$data['image' + n] = []
        this.imageError = null
      }
    },
    removeImage (n) {
      this.$data['image' + n + 'Url'] = []
      this.$data['image' + n] = []
      this.imageError = null
    }
  }
}
</script>
<style>
.input-box {
  padding: 0 30%;
}
</style>