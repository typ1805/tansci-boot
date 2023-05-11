<template> 
    <amisComponent :formid="state.formid" :formjson="state.formjson"></amisComponent>
</template>
<script setup lang="ts">
    import {reactive,onMounted} from "vue"
    import amisComponent from "../amis/AmisComponent.vue"
    import {getPagesInfo} from '@/api/lowcode/lcPages'
    import {useRoute} from 'vue-router'

    const route = useRoute()
    const state = reactive({
        formid: '',
        formjson: {}
    })

    onMounted(()=>{
        getPagesInfo(route.meta.id).then((res:any) => {
            if(res){
                state.formid = res.result.id
                state.formjson = JSON.parse(res.result.pageschema)
            }
        })
    })
</script>
<style scoped>
</style>
