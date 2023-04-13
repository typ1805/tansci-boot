<script setup lang="ts">
  import {onMounted, reactive, ref} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import {list,save,update,del} from '@/api/system/dict'

  const table = reactive({
    loading: false,
    operation:{
      isShow: true,
      width: '200'
    },
    tableTitle: [
    {prop:'dicLabel',label:'字典标签',align:'left'},
      {prop:'groupName',label:'分组名称'},
      {prop:'type',label:'字典类型'},
      {prop:'dicValue',label:'字典值'},
      {prop:'sort',label:'排序'},
      {prop:'createTime',label:'创建时间'},
      {prop:'remarks',label:'描述'}
    ],
    tableData: []
  })

  onMounted(()=>{
    onDictList()
  })

  function onDictList(){
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
    dictVisible: false,
    dictForm:{
      id: '',
      groupName: '',
      parentId: '0',
      type: '',
      dicValue: '',
      dicLabel: '',
      sort: 0,
      remarks: ''
    }
  })

  function onAdd(val:any){
    if(val){
      form.dictForm = {
        id: '',
        groupName: '',
        parentId: val.column.row.id,
        type: '',
        dicValue: '',
        dicLabel: '',
        sort: 0,
        remarks: ''
      }
    } else {
      form.dictForm = {
        id: '',
        groupName: '',
        parentId: '0',
        type: '',
        dicValue: '',
        dicLabel: '',
        sort: 0,
        remarks: ''
      }
    }
    form.operate = 0
    form.dictVisible = true
  }
  function onEdit(val:any){
    form.dictForm = {
      id: val.column.row.id,
      groupName: val.column.row.groupName,
      parentId: val.column.row.parentId,
      type: val.column.row.type,
      dicValue: val.column.row.dicValue,
      dicLabel: val.column.row.dicLabel,
      sort: val.column.row.sort,
      remarks: val.column.row.remarks
    }
    form.operate = 1
    form.dictVisible = true
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
          onDictList();
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
          save(form.dictForm).then(res=>{
            if(res){
              ElMessage.success("添加成功！");
              onDictList()
            }
          })
        } else {
          update(form.dictForm).then(res=>{
            if(res){
              ElMessage.success("更新成功！");
              onDictList()
            }
          })
        }
        form.operate = 0
        form.dictVisible = false
      }
    })
  }

</script>

<template>
  <el-card class="dict-container" shadow="always">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="false" :loading="table.loading">
      <template #search>
        <div><el-button @click="onAdd(null)" type="primary">添加</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onAdd(scope)" type="text" style="color:var(--add)">添加下级</el-button>
        <el-button @click="onEdit(scope)" type="text" style="color:var(--edit)">编辑</el-button>
        <el-button @click="onDelete(scope)" type="text" style="color:var(--delete)">删除</el-button>
      </template>
    </Table>
    <el-dialog title="字典信息" v-model="form.dictVisible" :show-close="false" width="40%">
      <el-form :model="form.dictForm" ref="formRef" :rules="rules" label-width="80px" status-icon>
        <el-row :gutter="20">
            <el-col :span="12">
                <el-form-item label="分组名称" prop="groupName" :rules="[{required: true,message:'请输入分组名称',trigger: 'blur'}]">
                    <el-input v-model="form.dictForm.groupName" placeholder="请输入分组名称" style="width: 100%"/>
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="类型" prop="type" :rules="[{required: true,message:'请选择类型',trigger: 'blur'}]">
                    <el-radio-group v-model="form.dictForm.type">
                        <el-radio :label="0">系统</el-radio>
                        <el-radio :label="1">业务</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-col>
        </el-row>
        <el-row :gutter="20">
            <el-col :span="12">
                <el-form-item label="字典名称" prop="dicLabel" :rules="[{required: true,message:'请输入字典名称',trigger: 'blur'}]">
                    <el-input v-model="form.dictForm.dicLabel" placeholder="请输入字典名称" style="width: 100%"/>
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="字典值" prop="dicValue" :rules="[{required: true,message:'请输入字典值',trigger: 'blur'}]">
                    <el-input v-model="form.dictForm.dicValue" placeholder="请输入字典值" style="width: 100%"/>
                </el-form-item>
            </el-col>
        </el-row>
        <el-row :gutter="20">
            <el-col :span="12">
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.dictForm.sort" :min="0" :max="999" controls-position="right" style="width: 100%"/>
                </el-form-item>
            </el-col>
        </el-row>
        <el-row :gutter="20">
            <el-col :span="24">
                <el-form-item label="描述" prop="remarks">
                    <el-input v-model="form.dictForm.remarks" type="textarea" placeholder="请输入描述" style="width: 100%"/>
                </el-form-item>
            </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="form.dictVisible = false">取消</el-button>
          <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
        </span>
      </template>
    </el-dialog>
  </el-card>
</template>
<style lang="scss" scoped>
  .dict-container{

  }
</style>