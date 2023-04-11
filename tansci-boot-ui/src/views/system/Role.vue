<script setup lang="ts">
  import {onMounted, reactive, ref, unref} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import {page,save,update,del} from '@/api/system/role'
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

  const formRef = ref<FormInstance>();
  const form = reactive({
    roleVisible: false,
    operate: 0,
    roleForm:{
      id:'',
      name:'',
      status: 0,
      remarks: ''
    },
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

  // 编辑
  function onEdit(val){
    
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

  // 添加信息
  function onAddRole(){
    
  }

  async function onSubmit (){
    const form = unref(formRef);
    if (!form) return;
    await form.validate();

  }

</script>
<template>
  <el-card class="role-container" shadow="always">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="true" :page="table.page" :loading="table.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange" @onSwitchChange="onSwitchChange">
      <template #search>
        <div><el-button type="info" @click="onAddRole">添加</el-button></div>
        <div><el-input v-model="name" placeholder="请输入名称"></el-input></div>
        <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
        <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onEdit(scope)" type='primary' text='primary' style="color:var(--edit); padding:0;">编辑</el-button>
        <el-button @click="onDelete(scope)" type='primary' text='primary' style="color:var(--delete); padding:0;">删除</el-button>
        <el-button @click="onMenuRole(scope)" type='primary' text='primary' style="color:var(--role); padding:0;">菜单权限</el-button>
        <el-button @click="onMenuRole(scope)" type='primary' text='primary' style="color:var(--role); padding:0;">权限</el-button>
      </template>
    </Table>
    <el-dialog title="权限信息" v-model="form.roleVisible" :show-close="false" width="40%">
        
        <template #footer>
            <span class="dialog-footer">
                <el-button @click="roleVisible = false">取消</el-button>
                <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
            </span>
        </template>
    </el-dialog>
  </el-card>
</template>
<style scoped lang="scss">
  .role-container{
    
  }
</style>