<script setup lang="ts">
  import { reactive, onMounted, getCurrentInstance } from "vue"

  const { proxy } = getCurrentInstance()
  const state = reactive({
    
  })

  onMounted(()=>{
      
  })

</script>
<template>
  <el-card class="home-container" :shadow="proxy.$global.cardShadow">
    首页
  </el-card>
</template>
<style lang="scss" scoped>
  .home-container{
    
  }
</style>