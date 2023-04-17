<script setup lang="ts">
    import { reactive, onMounted, getCurrentInstance } from "vue"
    
    const { proxy } = getCurrentInstance()

    const state = reactive({
        shadow: 'always',
    })

    onMounted(()=>{
        
    })

</script>
<template>
  <el-card class="codegen-container" :shadow="proxy.$global.cardShadow">
    开发中
  </el-card>
</template>
<style lang="scss" scoped>
  .codegen-container{
    
  }
</style>