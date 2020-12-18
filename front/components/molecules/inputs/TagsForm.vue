<template>
  <client-only>
    <VueTagsInput
      v-model="tag"
      :tags="initTags"
      :allow-edit-tags="true"
      @tags-changed="newTags => tags = newTags"
      placeholder="タグを追加"
    />
  </client-only>
</template>
<script>
export default {
  props: {
    value: {
      type: null
    },
    initTags: {
      type: Array
    }
  },
  data () {
    return {
      tag: '',
      tags: this.initTags
    }
  },
  watch: {
    tag (newValue) {
      this.$emit('input', newValue)
    },
    tags (newValue) {
      this.$emit('tags-changed', newValue)
    },
    value (newValue) {
      this.tag = newValue
    },
    created () {
      if (this.value) {
        this.tag =this.value
      }
    }
  }
}
</script>
<style>
.ti-tag {
  background-color: #FFA000 !important;
}
</style>