<script setup lang="ts">
    import {onMounted, reactive, ref, getCurrentInstance} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import {list,save,update,del} from '@/api/system/menu'
    import ElIcon from '@/components/ElIcon.vue'

    const { proxy } = getCurrentInstance()
    const menuFormRef = ref<FormInstance>();
    const state = reactive({
        treeData: [],
        operate: 0,
        type: 1,
        menuForm:{
            id: '',
            parentId: '',
            name: '',
            url: '',
            icon: '',
            chineseName: '',
            englishName: '',
            sort: 0,
            component: null,
            openMode: 0,
            isDel: 0,
            keepAlive: 0,
            isShow: 0,
            remarks: '',
            permission: null
        },
        menuId: null,
        iconVisible: false,
    })

    onMounted(()=>{
        onMenuTree()
    })

    function onMenuTree(){
        list().then((res:any)=>{
            if(res){
                state.treeData = res.result;
            }
        })
    }

    function onNodeClick(data:any){
        if(data.permission){
            state.type = 2;
        } else {
            state.type = 1;
        }
        state.operate = 0;
        state.menuId = data.id;
        state.menuForm = {
            id: data.id,
            parentId: data.parentId,
            name: data.name,
            url: data.url,
            icon: data.icon,
            chineseName: data.chineseName,
            englishName: data.englishName,
            sort: data.sort,
            component: data.component,
            openMode: data.openMode,
            isDel: data.isDel,
            keepAlive: data.keepAlive,
            isShow: data.isShow,
            remarks: data.remarks,
            permission: data.permission
        }
    }
    function onTypeChange(type:any){
        state.type = type
    }
    function onOperateChange(val:any){
        if(val == 1){
            let menuId = '0'
            if(state.menuId){
                menuId = state.menuId
            }
            state.operate = 1;
            state.menuForm = {
                id: '',
                parentId: menuId,
                name: '',
                url: '',
                icon: '',
                chineseName: '',
                englishName: '',
                sort: 0,
                component: null,
                openMode: 0,
                isDel: 0,
                keepAlive: 0,
                isShow: 0,
                remarks: '',
                permission: null
            }
        } else if(val == 2) {
            state.operate = 2;
        } else {
            if(!state.menuId){
                ElMessage.warning("请选择要删除的菜单！")
                return false;
            }
            
            state.operate = 0;
            ElMessageBox.confirm('此操作将永久删除该菜单, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                del(state.menuId).then(res=>{
                    if(res){
                        ElMessage.success("删除成功!");
                        state.menuForm = {
                            id: '',
                            parentId: '',
                            name: '',
                            url: '',
                            icon: '',
                            chineseName: '',
                            englishName: '',
                            sort: 0,
                            component: '',
                            openMode: 0,
                            isDel: 0,
                            keepAlive: 0,
                            isShow: 0,
                            remarks: '',
                            permission: null
                        };
                        onMenuTree();
                    }
                })
            }).catch(e=>{
                console.log(e)
            })
        }
    }
    function onFormIcon(){
        state.iconVisible = true;
    }
    function onIcon(val:any){
        state.menuForm.icon = val.name;
        state.iconVisible = false;
    }
    const onSubmit = async (formEl: FormInstance | undefined) =>{
        if (!formEl) return;
        await formEl.validate((valid)=>{
            if(valid){
                if(state.operate == 1){
                    save(state.menuForm).then(res=>{
                        if(res){
                            ElMessage.success("添加成功！");
                            onMenuTree();
                        }
                    })
                } else if (state.operate == 2) {
                    update(state.menuForm).then(res=>{
                        if(res){
                            ElMessage.success("更新成功！");
                            onMenuTree();
                        }
                    })
                }
                state.menuForm = {
                    id: '',
                    parentId: '',
                    name: '',
                    url: '',
                    icon: '',
                    chineseName: '',
                    englishName: '',
                    sort: 0,
                    component: null,
                    openMode: 0,
                    isDel: 0,
                    keepAlive: 0,
                    isShow: 0,
                    remarks: '',
                    permission: ''
                };
                state.operate = 0;
            }
        })
    }
</script>
<template>
    <el-card class="menu-container" :shadow="proxy.$global.cardShadow">
        <el-card class="menu-tree" shadow="never">
            <el-tree :data="state.treeData" :props="{children: 'children', label: 'chineseName'}" highlight-current @node-click="onNodeClick" empty-text="暂无菜单">
                <template #default="{ node, data }">
                    <span class="custom-tree-node">
                        <el-icon v-if="data.icon" style="vertical-align: middle;padding-right:10px;">
                            <component :is="data.icon"></component>
                        </el-icon>
                        <span>{{ node.label }}</span>
                    </span>
                </template>    
            </el-tree>
        </el-card>
        <el-card class="menu-form" shadow="never">
            <el-radio-group @change="onTypeChange" v-model="state.type">
                <el-radio-button :label="1">菜单</el-radio-button>
                <el-radio-button :label="2">按钮</el-radio-button>
            </el-radio-group>
            <el-divider direction="vertical" style="margin: 0 1rem;"/>
            <el-radio-group @change="onOperateChange" v-model="state.operate">
                <el-radio-button :label="1">添加</el-radio-button>
                <el-radio-button :label="2">编辑</el-radio-button>
                <el-radio-button :label="3">删除</el-radio-button>
            </el-radio-group>
            <el-divider content-position="left">菜单详情</el-divider>
            <el-form :model="state.menuForm" :rules="rules" ref="menuFormRef" :disabled="state.operate==0 || state.operate==3?true:false" label-position="right" label-width="150px">
                <el-form-item v-if="state.type == 1" label="菜单名称" prop="name" :rules="[{required: true, message: '名称不能为空', trigger: 'blur'},{pattern: /^[A-Za-z0-9]+$/, message: '必须是字母', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.name" placeholder="请输入名称" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="菜单路由" prop="url" :rules="[{required: true, message: '路由不能为空', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.url" placeholder="请输入路由" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="菜单图标" prop="icon" :rules="[{required: true, message: '菜单图标不能为空', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.icon" @click="onFormIcon" readonly suffix-icon="Platform" style="width:50%"></el-input>
                    <ElIcon :iconVisible="state.iconVisible" @onIcon="onIcon"/>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="中文名称" prop="chineseName" :rules="[{required: true, message: '中文名称不能为空', trigger: 'blur'},{pattern: /^[\u4e00-\u9fa5]{0,}$/, message: '必须是汉字', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.chineseName" placeholder="请输入中文名称" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="英文名称" prop="englishName" :rules="[{required: true, message: '英文名称不能为空', trigger: 'blur'},{pattern: /^[A-Za-z0-9]+$/, message: '必须是字母', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.englishName" placeholder="请输入英文名称" autocomplete="off" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 2" label="菜单名称" prop="chineseName" :rules="[{required: true, message: '请输入名称', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.chineseName" placeholder="请输入名称" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 2" label="权限标识" prop="permission" :rules="[{required: true, message: '请输入权限标识', trigger: 'blur'}]">
                    <el-input v-model="state.menuForm.permission" placeholder="请输入权限标识" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item label="菜单顺序" prop="sort" :rules="[{required: true, message: '菜单顺序不能为空', trigger: 'blur'}]">
                    <el-input-number v-model="state.menuForm.sort" :min="0" :max="999" style="width:50%"></el-input-number>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="组件名称" prop="component">
                    <el-input v-model="state.menuForm.component" placeholder="请输入组件名称" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="菜单类型" prop="openMode" :rules="[{required: true, message: '请选择类型', trigger: 'change'}]">
                    <el-select v-model="state.menuForm.openMode" placeholder="请选菜单类型" style="width:50%">
                        <el-option label="菜单" :value="0"></el-option>
                        <el-option label="Iframe" :value="1"></el-option>
                        <el-option label="新标签页" :value="2"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="是否缓存" prop="keepAlive" :rules="[{required: true, message: '请选择是否缓存', trigger: 'change'}]">
                    <el-radio-group v-model="state.menuForm.keepAlive">
                        <el-radio :label="1">缓存</el-radio>
                        <el-radio :label="0">不缓存</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item v-if="state.type == 1" label="是否显示" prop="isShow" :rules="[{required: true, message: '请选择是否显示', trigger: 'change'}]">
                    <el-radio-group v-model="state.menuForm.isShow">
                        <el-radio :label="1">显示</el-radio>
                        <el-radio :label="0">不显示</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="备注" prop="remarks">
                    <el-input v-model="state.menuForm.remarks" type="textarea" :rows="2" placeholder="请输入备注" style="width:50%"></el-input>
                </el-form-item>
                <el-form-item v-show="state.operate != 0 && state.operate != 3">
                    <el-button type="primary" @click="onSubmit(menuFormRef)">提交</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </el-card>
</template>
<style lang="scss">
    .menu-container{
        padding-bottom: 1.5rem;
        .menu-tree{
            float: left;
            margin-right: 1rem;
            min-width: 300px;
            min-height: 700px;
            .el-tree-node:hover>.el-tree-node__content{
                background-color: #fff !important;
                color: var(--theme) !important;
            }
            
            .el-tree--highlight-current .el-tree-node.is-current > .el-tree-node__content { 
                background-color: #fff !important;
                color: var(--theme) !important;
            }
        }
        .menu-form{
        }
    }
</style>