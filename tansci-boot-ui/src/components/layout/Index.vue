<script setup lang="ts">
    import { computed, reactive, onMounted, onBeforeMount, onDeactivated, getCurrentInstance } from "vue"
    import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
    import en from 'element-plus/dist/locale/en.mjs'
    import { getMenus } from "@/api/auth"
    import TbMenu from "./component/TbMenu.vue"
    import TbNavTabs from "./component/TbNavTabs.vue"
    import TbSetting from "./component/TbSetting.vue"
    import TbHeader from "./component/TbHeader.vue"

    const { proxy } = getCurrentInstance()
    const logo = new URL('../../assets/image/logo.png', import.meta.url).href
    const state = reactive({
        headerHeight: '40px',
        asideWidth: '220px',
        defaultHeight: null,
        isCollapse: false,
        language: 'zh-cn',
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

    function onCollapse(val:Boolean){
        if(val){
            state.isCollapse = false
            state.asideWidth = "220px"
        } else {
            state.isCollapse = true
            state.asideWidth = "80px"
        }
    }

    const locale = computed(() => (state.language === 'zh-cn' ? zhCn : en))
    function onLanguage(val:any){
        state.language = val
    }

</script>
<template>
    <div class="layout-container">
        <el-config-provider :locale="locale">
            <el-container>
                <el-aside :width="state.asideWidth">
                    <TbMenu :routers="state.routers" 
                        :logo="logo" 
                        :shadow="proxy.$global.cardShadow" 
                        :title="proxy.$global.title" 
                        :height="state.defaultHeight-105"
                        :isCollapse="state.isCollapse"
                        @onCollapse="onCollapse"/>
                </el-aside>
                <el-container>
                    <el-header :height="state.headerHeight">
                        <TbHeader/>
                        <!-- <TbNavTabs /> -->
                    </el-header>
                    <el-main>
                        <el-card :shadow="proxy.$global.cardShadow">
                            <el-scrollbar :height="state.defaultHeight-100">
                                <router-view />
                            </el-scrollbar>
                        </el-card>
                        <!-- <TbSetting :isCollapse="state.isCollapse" @onLanguage="onLanguage"/> -->
                    </el-main>
                </el-container>
            </el-container>
        </el-config-provider>
    </div>
</template>
<style lang="scss" scoped>
    .layout-container{
        height: 100%;
        background: var(--el-bg-color);
        .el-aside{
            margin: 0.2rem;
            padding: 0.1rem;
            overflow-x: auto;
            overflow-y: hidden;
            transition: all .5s;
        }
        .el-header{
            margin-top: 0.4rem;
            padding: 0 0.6rem 0 0;
        }
        .el-main{
            padding: 0rem 0.6rem 0 0;
            overflow-x: hidden;
            overflow-y: hidden;
        }
    }
</style>