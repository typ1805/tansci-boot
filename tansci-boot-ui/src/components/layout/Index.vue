<script setup lang="ts">
    import { reactive, onMounted, onBeforeMount, onDeactivated, getCurrentInstance } from "vue"
    import { getMenus } from "@/api/auth"
    import TbMenu from "./component/TbMenu.vue"
    import TbHeader from "./component/TbHeader.vue"

    const { proxy } = getCurrentInstance()
    const logo = new URL('../../assets/image/logo.png', import.meta.url).href
    const state = reactive({
        headerHeight: '52px',
        asideWidth: '260px',
        defaultHeight: null,
        routers: [],
    })

    onBeforeMount(() => {
        state.defaultHeight = (document.body.clientHeight || document.documentElement.clientHeight);
    })

    onMounted(()=>{
        // 获取菜单
        let routers:any = [];
        let _routes:any = getMenus();

        _routes.forEach((item:any)=>{
            if(item.children && item.isShow){
                routers.push(item)
            }
        })
        state.routers = routers

        window.addEventListener('resize', onDefaultHeight);
    })

    onDeactivated(()=>{
        window.removeEventListener('resize', onDefaultHeight, false)
    })

    function onDefaultHeight(){
        state.defaultHeight = window.innerHeight
    }

</script>
<template>
  <div class="layout-container">
    <el-container>
        <el-aside :width="state.asideWidth">
            <TbMenu :routers="state.routers" 
                :logo="logo" 
                :shadow="proxy.$global.cardShadow" 
                :title="proxy.$global.title" 
                :height="state.defaultHeight-105"/>
        </el-aside>
        <el-container>
            <el-header :height="state.headerHeight">
                <TbHeader :height="state.headerHeight"/>
            </el-header>
            <el-main>
                <el-card :shadow="proxy.$global.cardShadow">
                    <el-scrollbar :height="state.defaultHeight-126">
                        <router-view />
                    </el-scrollbar>
                </el-card>
            </el-main>
        </el-container>
    </el-container>
  </div>
</template>
<style lang="scss" scoped>
    .layout-container{
        height: 100%;
        background: var(--el-bg-color);
        .el-aside{
            margin: 0.2rem;
            padding: 0.4rem;
            overflow-x: auto;
            overflow-y: hidden;
        }
        .el-header{
            padding: 0 0.6rem 0 0;
        }
        .el-main{
            padding: 1.2rem 0.6rem 0 0;
            overflow-x: hidden;
            overflow-y: hidden;
        }
    }
</style>