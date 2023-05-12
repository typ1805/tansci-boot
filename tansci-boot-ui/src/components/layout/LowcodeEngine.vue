<template> 
    <amisComponent :formid="formid" :formjson="formjson"></amisComponent>
</template>
<script setup lang="ts">
    import {reactive, ref} from "vue"
    import amisComponent from "../amis/AmisComponent.vue"
    import {getPagesInfo} from '@/api/lowcode/lcPages'
    import {useRoute} from 'vue-router'

    const route = useRoute()
    const formid = ref('')
    const formjson = ref({})

    const init = () =>{
        getPagesInfo(route.meta.id).then((res:any) => {
            if(res){
                formid.value = res.result.id
                formjson.value = JSON.parse(res.result.pageschema)
            }
        })
    }

    init()
</script>
<style scoped>
</style>
