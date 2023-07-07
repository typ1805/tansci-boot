<script setup lang="ts">
  import { reactive, getCurrentInstance } from "vue"

  const { proxy } = getCurrentInstance()

  const state = reactive({
    url: proxy.$global.baseApi + '/api/web/index.html'
  })

</script>
<template>
  <div>
    <iframe :src="state.url" width="100%" height="100%" frameborder="0"></iframe>
  </div>
</template>
<style scoped>
  iframe{
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
  }
</style>