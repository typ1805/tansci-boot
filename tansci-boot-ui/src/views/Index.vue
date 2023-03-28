<script setup lang="ts">
    import { reactive, onMounted } from "vue"

    const state = reactive({
        shadow: 'always',
    })

    onMounted(()=>{
        
    })

</script>
<template>
  <el-card class="home-container" :shadow="state.shadow">
    首页
  </el-card>
</template>
<style lang="scss" scoped>
  .home-container{
    
  }
</style>