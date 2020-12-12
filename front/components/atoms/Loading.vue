<template>
  <div class="loader-container">
    <div class="loader">
      <div class="ball-scale-multiple">
        <div></div>
        <div></div>
        <div></div>
      </div>
    </div>
  </div>
</template>

<script>
import "loaders.css";
export default {
  data() {
    return {
      
    }
  },
};
</script>

<style  lang="scss" scoped>
.loader-container {
  position: fixed;
  top: 0;
  z-index: 999;
  width: 100%;
  height: 100vh;
  background: black;
  opacity: 0.7;
}

.loader {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  transform:scale(2, 2)
}
</style>