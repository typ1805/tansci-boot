<script setup lang="ts">
    import {reactive,ref,getCurrentInstance} from 'vue'
    import { isDark, toggleDark } from '@/composables'
    import type { FormInstance, Action } from 'element-plus'
    import { ElMessageBox } from 'element-plus'
    import { logout } from "@/api/auth"
    import { modifyPass } from "@/api/system/user"

    const { proxy } = getCurrentInstance()
    const emit = defineEmits(['onLanguage'])
	const props = defineProps({
        height: Number
	})
    
    const state = reactive({
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

</script>
<template>
    <div class="tb-setting">
        <div>
            <el-tooltip effect="light" placement="right">
                <template #default>
                    <el-button size="large" circle>
                        <template #icon>
                            <el-icon :size="22" color="#777aaf"><Setting /></el-icon>
                        </template>
                    </el-button>
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
        <div>
            <el-tooltip effect="light" placement="right">
                <template #default>
                    <el-button size="large" circle>
                        <template #icon>
                            <el-icon :size="22" color="#777aaf"><Mic /></el-icon>
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
            <el-tooltip effect="light" placement="right" content="全屏展示">
                <template #default>
                    <el-button @click="toggleDark()" size="large" circle >
                        <template #icon>
                            <el-icon :size="22" color="#777aaf"><Sunny v-show="!isDark"/></el-icon>
                            <el-icon :size="22" color="#777aaf"><Sunrise v-show="isDark"/></el-icon>
                        </template>
                    </el-button>
                </template>
            </el-tooltip>
        </div>
    </div>
</template>
<style lang="scss" scoped>
   .tb-setting{
    z-index: 9999;
        position: absolute;
        right: 1.5rem;
        // top: 0.4rem;
        bottom: 2rem;
        div{
            margin: 0.2rem 0;
        }
   }
</style>