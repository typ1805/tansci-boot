<script setup lang="ts">
    import { watch,reactive,ref,getCurrentInstance } from 'vue'
    import { isDark, toggleDark } from '@/composables'
    import type { FormInstance, Action } from 'element-plus'
    import { ElMessageBox } from 'element-plus'
    import { logout } from "@/api/auth"
    import { modifyPass } from "@/api/system/user"
    import { useRoute } from "vue-router"
    import { HOME_URL } from "@/config/config"

    const { proxy } = getCurrentInstance()
    const emit = defineEmits(['onLanguage'])
	const props = defineProps({
        height: Number
	})
    const route = useRoute();
    
    const state = reactive({
        tabsMenu: {},
        name: proxy.$global.user.info ? proxy.$global.user.info.nickname.slice(0,1) : '',
        avatarBg: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
        userVisible: false,
        user: {
            avatar: proxy.$global.user.info ? proxy.$global.user.info.avatar : '',
            username: proxy.$global.user.info ? proxy.$global.user.info.username : '',
            nickname: proxy.$global.user.info ? proxy.$global.user.info.nickname : '未登录',
            password: '',
            rePassword: '',
            oldPassword: ''
        }
    })

    function onPersonal(){
        state.userVisible = true
    }

    const userRef = ref<FormInstance>();
    const validatePass = (rule:any, value:any, callback:any) => {
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

    function onLogout(){
        ElMessageBox.confirm('确定要退出登录吗？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }).then(()=>{
            logout()
        })
    }

    watch(
        () => route.path,
        () => {
            if(HOME_URL != route.path){
                state.tabsMenu = {
                    title: route.meta.title as string,
                    path: route.path,
                    close: true
                };
            } else {
                state.tabsMenu = {}
            }
        },
        {
            immediate: true
        }
    )

</script>
<template>
    <div class="tb-header">
        <div class="breadcrumb">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item :to="{ path: HOME_URL }">首页</el-breadcrumb-item>
                <el-breadcrumb-item v-if="state.tabsMenu.path" :to="{ path: state.tabsMenu.path }">{{state.tabsMenu.title}}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="setting">
            <div>
                <el-tooltip effect="light" placement="bottom">
                    <template #default>
                        <el-button size="large" text>
                            <template #icon>
                                <el-icon :size="22"><Mic /></el-icon>
                            </template>
                        </el-button>
                    </template>
                    <template #content>
                        <div>
                            <el-button @click="$emit('onLanguage', 'zh-cn')" link>中文</el-button><br/>
                            <el-button @click="$emit('onLanguage', 'en')" link>English</el-button>
                        </div>
                    </template>
                </el-tooltip>
            </div>
            <div>
                <el-tooltip effect="light" placement="bottom" content="全屏展示">
                    <template #default>
                        <el-button @click="toggleDark()" size="large" text >
                            <template #icon>
                                <el-icon :size="22"><Sunny v-show="!isDark"/></el-icon>
                                <el-icon :size="22"><Sunrise v-show="isDark"/></el-icon>
                            </template>
                        </el-button>
                    </template>
                </el-tooltip>
            </div>
            <div>
                <el-tooltip effect="light" placement="bottom">
                    <template #default>
                        <el-avatar :size="30" :icon="!state.name?'UserFilled':''" :style="{margin: '4px 0 0 0', cursor: 'pointer'}">{{state.name}}</el-avatar>
                    </template>
                    <template #content>
                        <div style="text-align: center;">
                            <div><el-avatar :size="50" :src="state.user.avatar" /></div>
                            <div style="font-size: 22px; padding: 0.4rem 0;">{{state.user.username}}</div>
                            <el-button @click="onPersonal()" type="primary" plain>个人中心</el-button>
                            <el-button @click="onLogout()" type="danger" plain>注销登录</el-button>
                        </div>
                    </template>
                </el-tooltip>
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
        </div>
    </div>
</template>
<style lang="scss" scoped>
   .tb-header{
        display: flex;
        display: -webkit-flex;
        justify-content: space-between;
        align-items: center;
        .breadcrumb{

        }
        .setting{
            display: flex;
            display: -webkit-flex;
        }
   }
</style>