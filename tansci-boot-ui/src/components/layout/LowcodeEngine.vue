<template> 
    <amisComponent :formid="formid" :formjson="formjson"></amisComponent>
</template>
<script setup lang="ts">
    import {reactive, watch, ref} from "vue"
    import amisComponent from "../amis/AmisComponent.vue"
    import {getPagesInfo} from '@/api/lowcode/lcPages'
    import {useRoute,useRouter} from 'vue-router'

    const route = useRoute()
    const router = useRouter()
    const formid = ref('')
    const formjson = ref({})

    watch(()=> router.currentRoute, (data)=>{
            let _router:any = data.value
            getPagesInfo(_router.meta.id).then((res:any) => {
                if(res){
                    formid.value = res.result.id
                    formjson.value = JSON.parse(res.result.pageschema)
                }
            })
        },
        {immediate: true,deep: true}
    )
    
</script>
<style scoped>
</style>
