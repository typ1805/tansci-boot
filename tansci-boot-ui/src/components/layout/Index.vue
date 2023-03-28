<script setup lang="ts">
    import { reactive, onMounted, onBeforeMount, onDeactivated } from "vue"
    import { isDark, toggleDark } from '@/composables'
    import { useRouter } from 'vue-router'
    import Submenu from "@/components/Submenu.vue"
    import TabsMenu from "@/components/TabsMenu.vue"

    const router = useRouter()

    const logo = new URL('../../assets/image/logo.png', import.meta.url).href
    const state = reactive({
        headerHeight: '52px',
        asideWidth: '180px',
        routers: [],
        defaultHeight: null,
    })

    onBeforeMount(() => {
        state.defaultHeight = (document.body.clientHeight || document.documentElement.clientHeight);
    })

    onMounted(()=>{
        // 获取菜单
        let routers:any = [];
        let _routes = router.options.routes;
        _routes.forEach((item:any)=>{
            if(item.children && item.type == 0){
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
        <el-header :height="state.headerHeight">
            <div class="header-logo">
                <el-image :src="logo"></el-image>
            </div>
            <div class="header-content">
                <div class="header-dark">
                    <el-button @click="toggleDark()" link type="primary">
                        <template #icon>
                            <el-icon><Sunny v-show="!isDark"/></el-icon>
                            <el-icon><Moon v-show="isDark"/></el-icon>
                        </template>
                    </el-button>
                </div>
                <div class="header-login">
                    <el-button circle>
                        <template #icon>
                            <el-icon><UserFilled /></el-icon>
                        </template>
                    </el-button>
                </div>
            </div>
        </el-header>
        <el-container>
            <el-aside :width="state.asideWidth" :style="{height: state.defaultHeight+'px'}">
                <el-menu router :default-active="$route.path">
                    <template v-for="item in state.routers" :key="item">
                        <el-menu-item v-if="!item.children || item.children.length <= 1" :index="item.path">
                            <el-icon v-if="item.icon" style="vertical-align: middle;">
                                <component :is="item.icon"></component>
                            </el-icon>
                            <span style="vertical-align: middle;">{{item.meta.title}}</span>
                        </el-menu-item>
                        <Submenu v-else :data="item"></Submenu>
                    </template>
                </el-menu>
            </el-aside>
            <el-main> 
                <TabsMenu></TabsMenu>
                <router-view />
            </el-main>
        </el-container>
    </el-container>
  </div>
</template>
<style lang="scss" scoped>
    .layout-container{
        background: var(--el-bg-color);
        .el-header{
            display: flex;
            justify-content: space-between;
            line-height: 52px;
            .header-logo{
                display: flex;
                height: 52px;
                line-height: 52px;
                padding-left: 0.2rem;
                cursor: pointer;
            }
            .header-content{
                display: flex;
                justify-content: right;
            }
        }
        .el-aside{
            ::v-deep .el-menu{
                margin: 0 0.6rem;
                padding: 0 0.2rem;
                border-right: none;
                background: transparent;
                .el-menu-item, .el-sub-menu__title {
                    border-radius: 0.2rem;
                    height: 36px;
                    line-height: 36px;
                    margin: 0.4rem 0;
                }
                .el-menu-item, .el-menu-item-group__title, .el-sub-menu, .el-sub-menu__title{
                    padding-left: 0;
                }
                .el-sub-menu__title:hover{
                    background: transparent;
                    color: var(--theme);
                }
                .el-menu-item:hover{
                    background: transparent;
                    color: var(--theme);
                }
                .el-menu-item.is-active {
                    background: transparent;
                }
            }
        }
        .el-aside::-webkit-scrollbar{
            width: 0px;
        }
        .el-main{
            padding: 0;
            overflow-x: hidden;
            overflow-y: auto;
        }
        .el-main::-webkit-scrollbar{
            width: 0px;
        }
    }
</style>