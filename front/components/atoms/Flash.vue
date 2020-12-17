<template>
  <transition name="fade">
    <div v-if="flash.status" class="flash">{{flash.message}}</div>
  </transition>
</template>


<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters({
      flash: 'modules/info/flash'
    })
  }
}
</script>

<style scoped>
.flash {
  position: fixed;
  z-index: 50;
  text-align: center;
  line-height: 60px;
  width: 100%;
  background-color: orange;
  color: #fff;
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>