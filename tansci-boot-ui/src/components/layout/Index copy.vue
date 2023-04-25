<script setup lang="ts">
    import { reactive, onMounted, onBeforeMount, onDeactivated, getCurrentInstance, ref } from "vue"
    import type { FormInstance, Action } from 'element-plus'
    import { ElMessageBox } from 'element-plus'
    import { isDark, toggleDark } from '@/composables'
    import { getMenus, logout } from "@/api/auth"
    import { modifyPass } from "@/api/system/user"
    import Submenu from "@/components/Submenu.vue"
    import TabsMenu from "@/components/TabsMenu.vue"

    const { proxy } = getCurrentInstance()
    const logo = new URL('../../assets/image/logo.png', import.meta.url).href
    const state = reactive({
        headerHeight: '52px',
        asideWidth: '180px',
        routers: [],
        defaultHeight: null,
        userVisible: false,
        user: {
            avatar: '',
            username: '',
            nickname: '未登录',
            password: '',
            rePassword: '',
            oldPassword: ''
        }
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

        state.user = proxy.$global.user.info

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
        } else if('personal' === command){
            state.userVisible = true
        }
    }

    const userRef = ref<FormInstance>();
    const validatePass = (rule, value, callback) => {
        if (value === '') {
            callback(new Error('请输入确认密码'));
        } else if (value !== state.user.password) {
            callback(new Error('两次输入密码不一致!'));
        } else {
            callback();
        }
    }
    const onUserSubmit = async (formEl: FormInstance | undefined) => {
    if (!formEl) return;
    await formEl.validate((valid)=>{
      if(valid){
        modifyPass({
            username: state.user.username, 
            password: state.user.password,
            oldPassword: state.user.oldPassword
        }).then(res=>{
            if(res){
                state.userVisible = false
                ElMessageBox.alert('修改密码成功，请重新登录！', '提示', {
                    confirmButtonText: '确定',
                    type: 'warning',
                    callback: (action: Action) =>{
                        logout()
                    }
                })
            }
        })
      }
    })
  }

</script>
<template>
  <div class="layout-container">
    <el-container>
        <el-header :height="state.headerHeight">
            <div class="header-logo">
                <el-image :src="logo"></el-image>
                <span class="title">{{proxy.$global.title}}</span>
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
                            <span>{{state.user.nickname}}</span>
                            <el-icon class="el-icon--right"><arrow-down /></el-icon>
                        </span>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item command="personal">个人中心</el-dropdown-item>
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
                <el-card :shadow="proxy.$global.cardShadow" style="margin: 0.3rem;">
                    <el-scrollbar :height="state.defaultHeight-150">
                        <router-view />
                    </el-scrollbar>
                </el-card>
            </el-main>
        </el-container>
        <el-backtop target=".el-main"></el-backtop>
    </el-container>
    <el-dialog v-model="state.userVisible" title="个人中心" width="40%" :show-close="false">
        <el-form :model="state.user" ref="userRef" :rules="rules" label-width="80px" status-icon>
            <el-row :gutter="20">
                <el-col :span="24">
                    <el-form-item label="用户头像" prop="avatar">
                        <el-avatar :size="50" :src="state.user.avatar" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="12">
                    <el-form-item label="用户名称" prop="username">
                        <el-input v-model="state.user.username" disabled style="width: 100%"/>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="用户昵称" prop="nickname">
                        <el-input v-model="state.user.nickname" disabled placeholder="请输入昵称" style="width: 100%"/>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="12">
                    <el-form-item label="用户电话" prop="phone">
                        <el-input v-model="state.user.phone" disabled style="width: 100%"/>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="用户邮箱" prop="email">
                        <el-input v-model="state.user.email" disabled style="width: 100%"/>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="24">
                    <el-form-item label="原始密码" prop="oldPassword" :rules="[{required: true, message: '请输入原始密码', trigger: 'blur'}]">
                        <el-input v-model="state.user.oldPassword" type="password" placeholder="请输入原始密码" style="width: 100%"/>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="24">
                    <el-form-item label="用户密码" prop="password" :rules="[{required: true, message: '请输入密码', trigger: 'blur'},
                        {pattern: /^[a-zA-Z]\w{5,17}$/, message: '以字母开头，长度在6~18之间，只能包含字母、数字和下划线', trigger: 'blur'}]">
                        <el-input v-model="state.user.password" type="password" placeholder="请输入密码" style="width: 100%"/>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="24">
                    <el-form-item prop="rePassword" label="确认密码" :rules="[{required: true, message: '请输入确认密码', trigger: 'blur'},{validator: validatePass, trigger: 'blur'}]">
                        <el-input v-model="state.user.rePassword" type="password" placeholder="请输入确认密码"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>
        <template #footer>
            <el-button @click="onUserSubmit(userRef)" type="primary">修改密码</el-button>
        </template>
    </el-dialog>
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
                .title{
                    padding-left: 0.6rem;
                    color: var(-t);
                    font-weight: 700;
                    font-size: 18px;
                }
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
            overflow-y: hidden;
        }
        .el-main::-webkit-scrollbar{
            width: 0px;
        }
    }
</style>