<template> 
    <div id="amisid" ref="boxRef"></div>
</template>
<script setup lang="ts">
    import {defineProps,onMounted,watch,toRaw,ref} from "vue"
    import {ElMessage} from 'element-plus'
    import 'amis/sdk/sdk.js'
    import 'amis/lib/themes/default.css'
    import axios from 'axios'
    import copy from 'copy-to-clipboard'
    import {getToken} from '@/api/auth'

    const props = defineProps({
        formid: {
            type: String,
            default: () => {
                return ''
            }
        },
        formjson: {
            type: Object,
            default: () => {
                return {}
            }
        }
    })

    // @ts-ignore
    const amis = amisRequire('amis/embed');
    const boxRef = ref(null)

    watch(()=> props.formjson, (data)=>{
            onRendering(data)
        },
        {immediate: true,deep: true}
    )

    function onRendering(data:any){
        // let amisScoped = amis.embed('#amisid', data);
        let theme = 'cxd'
        let amisScoped = amis.embed( 
            '#amisid',
            data,
            {
                updateLocation: (to, replace) => {},
            },
            {
                // 下面三个接口必须实现
                fetcher: ({
                    url, // 接口地址
                    method, // 请求方法 get、post、put、delete
                    data, // 请求数据
                    responseType,
                    config, // 其他配置
                    headers ,// 请求头
                    updateLocation
                }) => {
                    config = config || {};
                    config.withCredentials = true;
                    
                    // 设置接口地址
                    config.baseURL = import.meta.env.VITE_APP_BASE_API;
            
                    responseType && (config.responseType = responseType);
            
                    if (config.cancelExecutor) {
                        config.cancelToken = new (axios).CancelToken(
                            config.cancelExecutor
                        );
                    }
            
                    config.headers = headers || {};
                    
                    // 设置token
                    const isToken = (config.headers || {}).isToken === false
                    if (getToken() && !isToken) {
                        config.headers['token'] = getToken() 
                    }
            
                    if (method !== 'post' && method !== 'put' && method !== 'patch') {
                        if (data) {
                            config.params = data;
                        }
                
                        return (axios )[method](url, config);
                    } else if (data && data instanceof FormData) {
                        config.headers = config.headers || {};
                        config.headers['Content-Type'] = 'multipart/form-data';
                    } else if (data && typeof data !== 'string' && !(data instanceof Blob) && !(data instanceof ArrayBuffer)) {
                        data = JSON.stringify(data);
                        config.headers = config.headers || {};
                        config.headers['Content-Type'] = 'application/json';
                    }
            
                    return (axios )[method](url, data, config);
                },
                isCancel: (value) => (axios ).isCancel(value),
                copy: content => {
                    copy(content);
                    ElMessage.success('内容已复制到粘贴板');
                },
                theme
            }
        )
    }
</script>
<style scoped>
</style>
