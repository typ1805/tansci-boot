<script setup lang="ts">
    import { reactive, onMounted, onBeforeMount, onDeactivated } from "vue"
    import { isDark, toggleDark } from '@/composables'
    import { getUser, getMenus, logout } from "@/api/auth"
    import Submenu from "@/components/Submenu.vue"
    import TabsMenu from "@/components/TabsMenu.vue"

    const logo = new URL('../../assets/image/logo.png', import.meta.url).href
    const state = reactive({
        headerHeight: '52px',
        asideWidth: '180px',
        routers: [],
        defaultHeight: null,
        username: '未登录'
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

        let user:any = getUser()
        if(user){
            state.username = user.nickname
        }

        window.addEventListener('resize', onDefaultHeight);
    })

    onDeactivated(()=>{
        window.removeEventListener('resize', onDefaultHeight, false)
    })

    function onDefaultHeight(){
        state.defaultHeight = window.innerHeight
    }
    function onHeaderCommand(command:any){
        if('logout' === command){
            logout()
        } else if('password' === command){

        }
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
                            <el-icon :size="20"><Sunny v-show="!isDark"/></el-icon>
                            <el-icon :size="20"><Moon v-show="isDark"/></el-icon>
                        </template>
                    </el-button>
                </div>
                <div class="header-login">
                    <el-dropdown @command="onHeaderCommand">
                        <span class="el-dropdown-link">
                            <span>{{state.username}}</span>
                            <el-icon class="el-icon--right"><arrow-down /></el-icon>
                        </span>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item command="password">修改密码</el-dropdown-item>
                                <el-dropdown-item command="logout">退出</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
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
                .header-dark{
                    padding-right: 1rem;
                }
                .header-login{
                    .el-dropdown{
                        cursor: pointer;
                        line-height: 52px;
                    }
                }
            }
        }
        .el-aside{
            :deep(.el-menu) {
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