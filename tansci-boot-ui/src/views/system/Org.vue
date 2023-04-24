<script setup lang="ts">
  import {onMounted, reactive, ref} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import {list,save,update,del} from '@/api/system/org'

  const table = reactive({
    loading: false,
    operation:{
      isShow: true,
      width: '200'
    },
    tableTitle: [
      {prop:'code',label:'组织编码',align:'left'},
      {prop:'name',label:'组织名称'},
      {prop:'name',label:'组织名称'},
      {prop:'sort',label:'排序'},
      {prop:'createTime',label:'创建时间'},
      {prop:'remarks',label:'描述'}
    ],
    tableData: []
  })

  onMounted(()=>{
    onOrgList()
  })

  function onOrgList(){
    table.loading = true;
    list({}).then((res:any)=>{
      if(res){
        table.loading = false;
        table.tableData = res.result;
      }
    })
  }

  const formRef = ref<FormInstance>()
  const form = reactive({
    operate: 0,
    orgVisible: false,
    orgForm:{
      id: '',
      name: '',
      parentId: '0',
      sort: 0,
      remarks: ''
    }
  })

  function onAdd(val:any){
    if(val){
      form.orgForm = {
        id: '',
        name: '',
        parentId: val.column.row.id,
        sort: 0,
        remarks: ''
      }
    } else {
      form.orgForm = {
        id: '',
        name: '',
        parentId: '0',
        sort: 0,
        remarks: ''
      }
    }
    form.operate = 0
    form.orgVisible = true
  }
  function onEdit(val:any){
    form.orgForm = {
      id: val.column.row.id,
      name: val.column.row.name,
      parentId: val.column.row.parentId,
      sort: val.column.row.sort,
      remarks: val.column.row.remarks
    }
    form.operate = 1
    form.orgVisible = true
  }
  function onDelete(val:any){
    ElMessageBox.confirm('此操作将永久删除, 是否继续?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      del(val.column.row.id).then(res=>{
        if(res){
          ElMessage.success('删除成功!');
          onOrgList();
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
          save(form.orgForm).then(res=>{
            if(res){
              ElMessage.success("添加成功！");
              onOrgList()
            }
          })
        } else {
          update(form.orgForm).then(res=>{
            if(res){
              ElMessage.success("更新成功！");
              onOrgList()
            }
          })
        }
        form.operate = 0
        form.orgVisible = false
      }
    })
  }

</script>

<template>
  <div class="org-container">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="false" :loading="table.loading">
      <template #search>
        <div><el-button @click="onAdd(null)" v-permission="'org:save'" type="primary">添加</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onAdd(scope)" v-permission="'org:save'" link style="color:var(--add)">添加下级</el-button>
        <el-button @click="onEdit(scope)" v-permission="'org:update'" link style="color:var(--edit)">编辑</el-button>
        <el-button @click="onDelete(scope)" v-permission="'org:delete'" link style="color:var(--delete)">删除</el-button>
      </template>
    </Table>
    <el-dialog title="组织信息" v-model="form.orgVisible" :show-close="false" width="40%">
      <el-form :model="form.orgForm" ref="formRef" :rules="rules" label-width="80px" status-icon>
        <el-form-item label="名称" prop="name" :rules="[{required: true,message:'请输入名称',trigger: 'blur'}]">
          <el-input v-model="form.orgForm.name" placeholder="请输入名称" style="width: 100%"/>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="form.orgForm.sort" :min="0" :max="999" controls-position="right" style="width: 100%"/>
        </el-form-item>
        <el-form-item label="描述" prop="remarks">
          <el-input v-model="form.orgForm.remarks" type="textarea" placeholder="请输入描述" style="width: 100%"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="form.orgVisible = false">取消</el-button>
          <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>
<style lang="scss" scoped>
  .org-container{

  }
</style>