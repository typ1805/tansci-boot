<script setup lang="ts">
    import { reactive, onMounted } from "vue"

    const state = reactive({
        shadow: 'always',
    })

    onMounted(()=>{
        
    })

</script>
<template>
  <el-card class="interface-container" :shadow="state.shadow">
    开发中
  </el-card>
</template>
<style lang="scss" scoped>
  .interface-container{
    
  }
</style>