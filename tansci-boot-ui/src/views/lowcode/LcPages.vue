<script setup>
    import {onMounted, reactive, getCurrentInstance, ref} from 'vue'
    import {ElMessage,ElMessageBox} from 'element-plus'
    import {getToken} from '@/api/auth'
    import {page,save,update,bindMenu,del,batchDelete} from '@/api/lowcode/lcPages'
    import {classifyList,classifySave,classifyUpdate,classifyDel} from '@/api/lowcode/lcPagesClassify'
    import {list} from '@/api/system/menu'

    const { proxy } = getCurrentInstance()
    const renameFormRef = ref()
    const menuFormRef = ref()
    const addFormRef = ref()
    const classifyFormRef = ref()
    const state = reactive({ 
        loading: false,
        search: {
            parentId: null,
            title: null,
            classify: null,
        },
        selectIds: [],
        page: {
            current: 1,
            size: 8,
            total: 0,
        },
        data: [],
        menuVisible: false,
        menuList: [],
        menuForm: {
            id: '',
            menuId: []
        },
        addVisible: false,
        viewVisible: false,
        operate: 0,
        addForm: {
            id: '',
            title: '',
            subtitle: '',
            parentId: '0',
            status: 0,
            classify: '',
            pageschema: '{}',
            remarks: null
        },
        classifyData:[],
        classifyOperate: 0,
        classifyVisible: false,
        classifyForm:{
            name: "",
            parentId: null,
            remarks: null
        }
    })

    onMounted(()=>{
        onClassifyList()
        onLcPages()
    })

    function onLcPages(){
        state.loading = true
        page(Object.assign(state.page,state.search)).then(res=>{
            state.loading = false;
            state.data = res.result.records;
            state.page.current = res.result.current;
            state.page.size = res.result.size;
            state.page.total = res.result.total;
        })
    }

    function onSizeChange(e){
        state.page.size = e;
        onLcPages();
    }
    function onCurrentChange(e){
        state.page.current = e;
        onLcPages();
    }
    function onSearch(){
        onLcPages()
    }
    function onRefresh(){
        state.search = {
            parentId: null,
            title: null,
            classify: null,
        }
        onLcPages();
    }

    function onPageClick(val){
        state.search.parentId = val.id
        onLcPages()
    }

    function onPageDesign(val){
        let id = window.btoa(val.id+","+getToken())
        window.open(proxy.$global.editorUrl + '/gh-pages/index.html#/edit/0g?id=' + id, '_blank')
    }

    function onRename(val){
        state.addForm = {
            id: val.id,
            title: val.title,
            subtitle: val.subtitle,
            parentId: val.parentId,
            remarks: val.remarks,
            status: val.status,
            classify: val.classify,
            pageschema: val.pageschema,
        }
        state.operate = 1
        state.addVisible = true;
    }

    function onDelete(val){
        ElMessageBox.confirm('此操作会永久删除, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            del(val.id).then((res) => {
                ElMessage.success('操作成功!');
                onLcPages()
            })
        })
    }
    function onBatchDelete(){
        ElMessageBox.confirm('此操作会永久删除选中的所有数据, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
           batchDelete({ids: state.selectIds}).then((res) => {
                ElMessage.success('操作成功!');
                onLcPages()
            })
        })
    }

    function onContextMenu(val){
        list({isShow: 1}).then((res) => {
            state.menuList = res.result;
            let menuIds = []
            if(Object.prototype.toString.call(val.menuIds) === '[object Array]'){
                menuIds = val.menuIds
            } else {
                menuIds = val.menuIds ? [val.menuIds] : []
            }
            state.menuForm = {
                id: val.id,
                menuId: menuIds
            }
            state.menuVisible = true
        })
    }
    function onContextMenuSubmit(){
        ElMessageBox.confirm('此操作会将已绑定的菜单覆盖, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(()=>{
            menuFormRef.value.validate((valid) => {
                if (valid) {
                    bindMenu({
                        id: state.menuForm.id, 
                        menuIds: state.menuForm.menuId
                    }).then((res) => {
                        onLcPages()
                        state.menuForm = {}
                        state.menuVisible = false
                    }).catch( e => 
                        ElMessage.error(e.msg)
                    )
                }
            })
        })
    }

    function onSelecting(id){
        let selectIds = []
        state.data.forEach(item=>{
            let d = document.getElementById("page" + item.id);
            if(item.checked || item.checked == 1){
                d.style.border="1px solid #409EFF";
                selectIds.push(item.id) 
            } else {
                d.style.border="1px solid #e4e7ed";
            }
        })
        state.selectIds = selectIds
    }
    function onSelectAll(){
        if(state.selectIds && state.selectIds.length == state.data.length){
            state.data.forEach(item=>{
                item.checked = 0
                let d = document.getElementById("page" + item.id);
                d.style.border="1px solid #e4e7ed";
            })
            state.selectIds = []
        } else {
            let selectIds = []
            state.data.forEach(item=>{
                item.checked = 1
                let d = document.getElementById("page" + item.id);
                d.style.border="1px solid #409EFF";
                selectIds.push(item.id)
            })
            state.selectIds = selectIds
        }
    }

    function onAdd(){
        state.addForm = {
            title: '',
            subtitle: '',
            parentId: state.search.parentId,
            remarks: '',
            status: 0,
            classify: '',
            pageschema: '{}'
        }
        state.operate = 0
        state.addVisible = true;
    }

    function onAddSubmit(){
        addFormRef.value.validate((valid) => {
            if (valid) {
                if(state.operate == 0){
                    save(state.addForm).then((res) => {
                        onLcPages()
                        state.addVisible = false
                    }).catch( e => 
                        ElMessage.error(e.msg)
                    )
                } else {
                    update(state.addForm).then((res) => {
                        onLcPages()
                        state.addVisible = false
                    }).catch( e => 
                        ElMessage.error(e.msg)
                    )
                }
            }
        })
    }

    // =================分类=================
    function onClassifyList(){
        classifyList().then(res=>{
            state.classifyData = res.result;
        })
    }

    function onNodeClick(data){
        state.search.classify = data.id;
        onSearch()
    }

    function onOperateChange(val,type){
        if(type == 1){
            state.classifyForm = {
                id: '',
                parentId: val.id,
                name: '',
                remarks: ''
            }
            state.classifyOperate = 0
            state.classifyVisible = true;
        } else if(type == 2) {
            state.classifyForm = {
                id: val.id,
                parentId: val.parentId,
                name: val.name,
                remarks: val.remarks
            }
            state.classifyOperate = 1
            state.classifyVisible = true;
        } else {
            state.operate = 0;
            ElMessageBox.confirm('此操作将永久删除该菜单, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                classifyDel(val.id).then(res=>{
                    if(res){
                        ElMessage.success("删除成功!");
                        state.classifyForm = {
                            id: '',
                            parentId: null,
                            name: '',
                            remarks: ''
                        };
                        onClassifyList()
                    }
                })
            }).catch(e=>{
                console.log(e)
            })
        }
    }

    function onClassifySubmit(){
        classifyFormRef.value.validate((valid) => {
            if (valid) {
                if(state.classifyOperate == 0){
                    classifySave(state.classifyForm).then((res) => {
                        onClassifyList()
                        state.classifyVisible = false
                    }).catch( e => 
                        ElMessage.error(e.msg)
                    )
                } else {
                    classifyUpdate(state.classifyForm).then((res) => {
                        onClassifyList()
                        state.classifyVisible = false
                    }).catch( e => 
                        ElMessage.error(e.msg)
                    )
                }
            }
        })
    }

</script>
<template>
  <div class="lc-pages">
        <div class="pages-classify">
            <el-scrollbar height="45rem">
                <el-tree :data="state.classifyData" :props="{children: 'children', label: 'name'}" highlight-current @node-click="onNodeClick" empty-text="暂无数据">
                    <template #default="{ node, data }">
                        <el-tooltip placement="right-start" effect="light">
                            <span class="custom-tree-node">
                                <el-icon v-if="data.icon" style="vertical-align: middle;padding-right:10px;">
                                    <component :is="data.icon"></component>
                                </el-icon>
                                <span>{{ node.label }}</span>
                            </span>
                            <template #content>
                                <el-button-group size="mini">
                                    <el-button @click="onOperateChange(data,1)" icon="check"></el-button>
                                    <el-button @click="onOperateChange(data,2)" icon="edit"></el-button>
                                    <el-button @click="onOperateChange(data,3)" icon="delete"></el-button>
                                </el-button-group>
                            </template>
                        </el-tooltip>
                    </template>    
                </el-tree>
            </el-scrollbar>
            <el-dialog v-model="state.classifyVisible" title="分类管理" :show-close="false" width="30%">
                <el-form :model="state.classifyForm" ref="classifyFormRef" :rules="rules" label-width="60px" status-icon>
                    <el-form-item v-show="state.classifyForm.parentId != '0'" label="父级" prop="parentId" :rules="[{required: true, message: '请选择父级', trigger: 'blur'}]">
                        <el-tree-select v-model="state.classifyForm.parentId" :data="state.classifyData" :props="{children: 'children', label: 'name'}" node-key="id" 
                check-strictly :render-after-expand="false" :default-checked-keys="[state.classifyForm.parentId]" :default-expanded-keys="[state.classifyForm.parentId]" placeholder="请选父级" style="width:100%"/>
                    </el-form-item>
                     <el-form-item label="名称" prop="name" :rules="[{required: true, message: '请输入名称', trigger: 'blur'}]">
                        <el-input v-model="state.classifyForm.name" placeholder="请输入名称" />
                    </el-form-item>
                </el-form>
                <template #footer>
                <span class="dialog-footer">
                    <el-button @click="state.classifyVisible = false">取消</el-button>
                    <el-button type="primary" @click="onClassifySubmit">确认</el-button>
                </span>
                </template>
            </el-dialog>
        </div>
        <div class="pages-list">
            <div class="pages-search">
                <el-input v-model="state.search.title" placeholder="请输入标题搜索" style="width: 12%; margin-right: 1rem;"/>
                <el-button @click="onRefresh" icon="RefreshRight" circle></el-button>
                <el-button @click="onSearch" type="primary" icon="Search">查询</el-button>
            </div>
            <div class="pages-main">
                <el-card shadow="never">
                    <div class="main-operate">
                        <el-button @click="onSelectAll()">全选</el-button>
                        <el-button @click="onAdd()" type="primary">新增</el-button>
                        <el-button @click="onBatchDelete()" :disabled="state.selectIds && state.selectIds.length == 0" type="danger">批量删除</el-button>
                        <el-button v-if="state.search.parentId && state.search.parentId != '0'" @click="onRefresh()" type="primary" icon="Back" style="float: right;">返回</el-button>
                    </div>
                    <div v-if="state.data" v-loading="state.loading" class="main-card">
                        <el-card v-for="item in state.data" :key="item" shadow="hover" :body-style="{ padding: '0px' }" :id="'page'+item.id" style="margin: 0.4rem;">
                            <template #header>
                                <div class="card-header">
                                    <el-text tag="b">{{item.title}}</el-text>
                                    <el-checkbox @change="onSelecting()" v-model="item.checked" :true-label="1" :false-label="0"/>
                                </div>
                            </template>
                            <div @click="onPageClick(item)" class="card-content">
                                <el-icon v-if="!item.menuIds || item.menuIds.length == 0" size="100" color="#E6A23C"><Setting /></el-icon>
                                <el-icon v-else size="100" color="#67C23A"><UploadFilled /></el-icon>
                                <div class="content">
                                    <div class="content-item">
                                        <el-text truncated>{{item.subtitle}}</el-text>
                                        <div>
                                            <el-tag v-if="item.status == 0" type="success" effect="light" round>已发布</el-tag>
                                            <el-tag v-else type="warning" effect="light" round>未发布</el-tag>
                                        </div>
                                    </div>
                                    <div>
                                        <el-text truncated tag="sub" size="small" style="max-width:12rem;padding-top:0.4rem;font-size:12px;">{{item.remarks}}</el-text>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <el-button-group style="width:100%; display: flex;">
                                <el-button @click="onPageDesign(item)" icon="Edit" style="width:100%; border-left: none;">设计页面</el-button>
                                    <el-button @click="onRename(item)" icon="EditPen" style="width:100%">修改</el-button>
                                    <el-button @click="onDelete(item)" icon="Delete" style="width:100%">删除</el-button>
                                    <el-button @click="onContextMenu(item)" icon="Connection" style="width:100%; border-right: none;">关联菜单</el-button>
                                </el-button-group>
                            </div>
                        </el-card>
                    </div>
                    <el-pagination v-if="state.data && state.data.length > 0" :current-page="state.page.current" :page-size="state.page.size" :total="state.page.total"
                        layout="total, prev, pager, next, jumper"
                        @size-change="onSizeChange"
                        @current-change="onCurrentChange" style="margin-top: 1.2rem;"/>
                    <div v-if="!state.data || state.data.length == 0">
                        <el-empty description="暂无数据" />
                    </div>
                </el-card>
                <el-dialog v-model="state.menuVisible" title="关联菜单" :show-close="false" width="30%">
                    <el-form :model="state.menuForm" ref="menuFormRef" :rules="rules" label-width="60px" status-icon>
                        <el-form-item label="菜单" prop="menuId" :rules="[{required: true, message: '请选择菜单', trigger: 'blur'}]">
                            <el-tree-select v-model="state.menuForm.menuId" :data="state.menuList" :props="{children: 'children', label: 'chineseName'}" node-key="id" multiple :render-after-expand="false" :default-checked-keys="state.menuForm.menuId" :default-expanded-keys="state.menuForm.menuId" style="width:100%;"/>
                        </el-form-item>
                    </el-form>
                    <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="state.menuVisible = false">取消</el-button>
                        <el-button type="primary" @click="onContextMenuSubmit">确认</el-button>
                    </span>
                    </template>
                </el-dialog>
                <el-dialog v-model="state.addVisible" title="新增页面" :show-close="false" width="40%">
                    <el-form :model="state.addForm" ref="addFormRef" :rules="rules" label-width="100px" status-icon>
                        <el-form-item label="页面名称" prop="title" :rules="[{required: true, message: '请输入名称', trigger: 'blur'}]">
                            <el-input v-model="state.addForm.title" placeholder="请输入名称" />
                        </el-form-item>
                        <el-form-item label="页面标题" prop="subtitle" :rules="[{required: true, message: '请输入标题', trigger: 'blur'}]">
                            <el-input v-model="state.addForm.subtitle" placeholder="请输入标题"/>
                        </el-form-item>
                        <el-form-item label="页面状态" prop="status" :rules="[{required: true, message: '请选择状态', trigger: 'blur'}]">
                            <el-switch v-model="state.addForm.status" inline-prompt active-text="是" :active-value="0" inactive-text="否" :inactive-value="1"/>
                        </el-form-item>
                        <el-form-item label="页面分类" prop="status" :rules="[{required: true, message: '请选择分类', trigger: 'blur'}]">
                        <el-tree-select v-model="state.addForm.classify" :data="state.classifyData" :props="{children: 'children', label: 'name'}" node-key="id" 
                check-strictly :render-after-expand="false" :default-checked-keys="[state.addForm.classify]" :default-expanded-keys="[state.addForm.classify]" placeholder="请选父级" style="width:100%"/>
                        </el-form-item>
                        <el-form-item label="页面描述" prop="remarks">
                            <el-input v-model="state.addForm.remarks" placeholder="请输入描述" type="textarea" :rows="2"/>
                        </el-form-item>
                    </el-form>
                    <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="state.addVisible = false">取消</el-button>
                        <el-button type="primary" @click="onAddSubmit">确认</el-button>
                    </span>
                    </template>
                </el-dialog>
            </div>
        </div>
  </div>
</template>
<style scoped lang="scss">
    .lc-pages{
        display: flex;
        .pages-classify{
            border-right: 1px solid #e4e7ed;
            margin: 0 1rem 0 1rem;
            min-width: 12rem;
            .el-tree-node:hover>.el-tree-node__content{
                background-color: #fff !important;
                color: var(--theme) !important;
            }
            
            .el-tree--highlight-current .el-tree-node.is-current > .el-tree-node__content { 
                background-color: #fff !important;
                color: var(--theme) !important;
            }
        }
        .pages-list{
            width: 100%;
            .pages-search{
                display: flex;
            }
            .pages-main{
                padding-top: 1rem;
                .main-operate{
                    padding-bottom: 1rem;
                }
                .main-card{
                    display: flex;
                    flex-wrap: wrap;  
                    justify-content: flex-start;
                    .el-card{
                        // flex: 0 0 24%;
                        :deep(.el-card__header){
                            padding: 1rem;
                            border: none;
                        }
                        .card-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }
                        .card-content{
                            display: flex;
                            align-items: center;
                            font-size: 12px;
                            color: #606266;
                            padding: 0 0.4rem 1rem 0.4rem;
                            cursor: pointer;
                            .content{
                                width: 100%;
                                padding-left: 1.2rem;
                                .content-item{
                                    display: flex;
                                    justify-content: space-between;
                                }
                            }
                        }
                        .card-footer{
                            .el-button{
                                border-bottom: none;
                            }
                            .el-button-group>.el-button:first-child{
                                border-top-left-radius: 0;
                            }
                            .el-button-group>.el-button:last-child {
                                border-top-right-radius: 0;
                            }
                        }
                    }
                }
            }
        }
    }
</style>
