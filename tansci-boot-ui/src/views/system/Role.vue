<script setup lang="ts">
  import {onMounted, reactive, ref, unref} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import {page,save,update,del,dataPermissions,orgList,menuPermissions,menuList} from '@/api/system/role'
  import Table from '@/components/Table.vue'

  const searchForm = reactive({
    name: null,
  })

  const table = reactive({
    loading: false,
    page: {
      current: 1,
      size: 10,
      total: 1,
    },
    operation:{
      isShow: true,
      width: '240'
    },
    tableTitle: [
      {prop:'',label:'',fixed:'left'},
      {prop:'code',label:'角色编码'},
      {prop:'name',label:'角色名称'},
      {prop:'creator',label:'创建人'},
      {prop:'updateTime',label:'更新时间'},
      {prop:'createTime',label:'创建时间'},
      {prop:'remarks',label:'描述'}
    ],
    tableData:[],
  })

  onMounted(()=>{
    onRolePage()
  })

  function onRolePage(){
    table.loading = true;
    page(Object.assign(table.page, searchForm)).then((res:any)=>{
      if(res){
        table.loading = false;
        table.tableData = res.result.records;
        table.page.current = res.result.current;
        table.page.size = res.result.size;
        table.page.total = res.result.total;
      }
    })
  }

  function onSizeChange(e){
    table.page.size = e;
    onRolePage();
  }
  function onCurrentChange(e){
    table.page.current = e;
    onRolePage();
  }
  function onRefresh(){
    searchForm.name = null
    onRolePage();
  }
  function onSearch(){
    onRolePage();
  }

  const formRef = ref<FormInstance>();
  const form = reactive({
    roleVisible: false,
    operate: 0,
    permissionList :[
      {label: '全部', value: '0'},
      {label: '自定义', value: '1'},
      {label: '本级级子级', value: '2'},
      {label: '本级', value: '3'}
    ],
    roleForm:{
      id:'',
      name:'',
      permission: '',
      sort: 0,
      remarks: ''
    },
  })

  // 添加信息
  function onAddRole(){
    form.roleVisible = true
    form.operate = 0
    form.roleForm = {
      id:'',
      name:'',
      permission: '',
      sort: 0,
      remarks: ''
    }
  }
  // 编辑
  function onEdit(val:any){
    form.operate = 1
    form.roleForm = {
      id: val.column.row.id,
      name: val.column.row.name,
      permission: val.column.row.permission,
      sort: val.column.row.sort,
      remarks: val.column.row.remarks
    }
    form.roleVisible = true
  }
  // 删除
  function onDelete(val:any){
    ElMessageBox.confirm('此操作将永久删除, 是否继续?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      del(val.column.row.id).then(res=>{
        if(res){
          ElMessage.success('删除成功!');
          onRolePage();
        }
      })
    }).catch(e=>{
      console.log(e)
    })
  }
  const onSubmit = async (formEl: FormInstance | undefined) => {
    if (!formEl) return;
    await formEl.validate((valid)=>{
      if(valid){
        if(form.operate == 0){
          save(form.roleForm).then(res=>{
            if(res){
              ElMessage.success("添加成功！");
              onRolePage()
            }
          })
        } else {
          update(form.roleForm).then(res=>{
            if(res){
              ElMessage.success("更新成功！");
              onRolePage()
            }
          })
        }
        form.operate = 0
        form.roleVisible = false
      }
    })
  }

  // 数据、菜单权限
  const menuRef = ref()
  const orgRef = ref()
  const auth = reactive({
    authVisible: false,
    type: '',
    menuList: [],
    orgList: [],
    selected: [],
    roleId: ''
  })

  function onAuth(val:any, type:string){
    auth.type = type
    auth.roleId = val.column.row.id
    if(auth.type == 'menu'){
      menuList(val.column.row.id).then((res:any)=>{
        auth.menuList = res.result.list
        auth.selected = res.result.selected
      })
    } else{
      orgList(val.column.row.id).then((res:any)=>{
        auth.orgList = res.result.list
        auth.selected = res.result.selected
      })
    }
    auth.authVisible = true
  }

  function onAuthSubmit(){
    if(auth.type == 'menu'){
      const keys = unref(menuRef);
      if(keys.getCheckedKeys().length == 0){
        ElMessage.error("请先选择菜单！");
        return false;
      }
      menuPermissions({id: auth.roleId, menuIds: keys.getCheckedKeys()}).then(res=>{
        if(res){
          ElMessage.success("操作成功！");
        }
      })
    } else {
      const keys = unref(orgRef);
      if(keys.getCheckedKeys().length == 0){
        ElMessage.error("请先选择组织！");
        return false;
      }
      dataPermissions({id: auth.roleId, orgIds: keys.getCheckedKeys()}).then(res=>{
        if(res){
          ElMessage.success("操作成功！");
        }
      })
    }
    auth.authVisible = false
  }

</script>
<template>
  <div class="role-container">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="table.page" :loading="table.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange">
      <template #search>
        <div><el-button v-permission="'role:save'" type="primary" @click="onAddRole">添加</el-button></div>
        <div><el-input v-model="searchForm.name" placeholder="请输入名称"></el-input></div>
        <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
        <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onEdit(scope)" v-permission="'role:update'" type='primary' link style="color:var(--edit); padding:0;">编辑</el-button>
        <el-button @click="onDelete(scope)" v-permission="'role:delete'" type='primary' link style="color:var(--delete); padding:0;">删除</el-button>
        <el-button @click="onAuth(scope, 'menu')" v-permission="'role:menu'" type='primary' link style="color:var(--add); padding:0;">菜单权限</el-button>
        <el-button @click="onAuth(scope, 'org')" v-permission="'role:data'" type='primary' link style="color:var(--role); padding:0;">数据权限</el-button>
      </template>
    </Table>
    <el-dialog title="角色信息" v-model="form.roleVisible" :show-close="false" width="40%">
        <el-form :model="form.roleForm" ref="formRef" :rules="rules" label-width="80px" status-icon>
          <el-form-item label="名称" prop="name" :rules="[{required: true,message:'请输入名称',trigger: 'blur'}]">
            <el-input v-model="form.roleForm.name" placeholder="请输入名称" style="width: 100%"/>
          </el-form-item>
          <el-form-item label="权限" prop="permission" :rules="[{required: true,message:'请选择权限',trigger: 'change'}]">
            <el-select v-model="form.roleForm.permission" placeholder="请选择权限" style="width: 100%">
              <el-option v-for="item in form.permissionList" :key="item" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="排序" prop="sort">
            <el-input-number v-model="form.roleForm.sort" :min="0" :max="999" controls-position="right" style="width: 100%"/>
          </el-form-item>
          <el-form-item label="描述" prop="remarks">
            <el-input v-model="form.roleForm.remarks" type="textarea" placeholder="请输入描述" style="width: 100%"/>
          </el-form-item>
        </el-form>
        <template #footer>
            <span class="dialog-footer">
                <el-button @click="form.roleVisible = false">取消</el-button>
                <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
            </span>
        </template>
    </el-dialog>
    <el-dialog title="权限信息" v-model="auth.authVisible" :show-close="false" width="30%">
      <el-scrollbar height="400px">
        <el-tree v-if="auth.type == 'menu'" :data="auth.menuList" node-key="id" ref="menuRef" :default-expand-all="true"
          :props="{children: 'children',label: 'chineseName'}" :default-checked-keys="auth.selected" multiple show-checkbox />
        <el-tree v-if="auth.type == 'org'" :data="auth.orgList" node-key="id" ref="orgRef" :default-expand-all="true"
          :props="{children: 'children',label: 'name'}" :default-checked-keys="auth.selected" multiple show-checkbox />
      </el-scrollbar>
        <template #footer>
            <span class="dialog-footer">
                <el-button @click="auth.authVisible = false">取消</el-button>
                <el-button type="primary" @click="onAuthSubmit(authRef)">提交</el-button>
            </span>
        </template>
    </el-dialog>
  </div>
</template>
<style scoped lang="scss">
  .role-container{
    
  }
</style>