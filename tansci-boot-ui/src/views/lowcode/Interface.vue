<script setup lang="ts">
  import { reactive, getCurrentInstance } from "vue"

  const { proxy } = getCurrentInstance()

  const state = reactive({
    url: proxy.$global.baseApi + '/tansci/magic/web/index.html'
  })

</script>
<template>
  <e-card :shadow="proxy.$global.cardShadow">
    <iframe :src="state.url" width="100%" height="90%" frameborder="0"></iframe>
  </e-card>
</template>
<style scoped>
  
</style>