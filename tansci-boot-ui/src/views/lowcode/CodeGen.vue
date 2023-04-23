<script setup lang="ts">
  import { reactive, onMounted, ref } from "vue"
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import { page, del, execute } from "@/api/lowcode/codeGen"
  import { tables, columns, primary } from "@/api/lowcode/source"

  const searchForm = reactive({
    tableName: null
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
      {prop:'dataSource',label:'数据源'},
      {prop:'tableName',label:'表名'},
      {prop:'tableComment',label:'表注释'},
      {prop:'subTableName',label:'子表名称'},
      {prop:'subTableComment',label:'子表注释'},
      {prop:'updateTime',label:'更新时间'},
      {prop:'createTime',label:'创建时间'}
    ],
    tableData:[],
  })

  onMounted(()=>{
    onCodeGenPage()
  })

  function onCodeGenPage(){
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
    onCodeGenPage();
  }
  function onCurrentChange(e){
    table.page.current = e;
    onCodeGenPage();
  }
  function onRefresh(){
    searchForm.tableName = null
    onCodeGenPage();
  }
  function onSearch(){
    onCodeGenPage();
  }
  
  const formRef = ref<FormInstance>()
  const form = reactive({
    tableList: [],
    columnList: [],
    primary:'',
    tabsActive: 'table',
    codeVisible: false,
    codeForm: {
      tableName: '',
      tableSchema: '',
      tableComment: '',
    }
  })

  function onTables(){
    tables({name: 'tansci_boot'}).then((res:any)=>{
      form.tableList = res.result
    })
  }

  function onColumns(name:String){
    columns({name: name}).then((res:any)=>{
      form.columnList = res.result
    })
  }

  function onPrimary(name:String){
    primary({name: name}).then((res:any)=>{
      form.primary = res.result
    })
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
          onCodeGenPage();
        }
      })
    }).catch(e=>{
      console.log(e)
    })
  }

  function onAdd(){
    onTables()
    form.tabsActive = 'table'
    form.codeVisible = true
  }

  function onTabsClick(tab:any){
    form.tabsActive = tab.paneName.value
  }

  function onTablechange(val:any){
    let table = form.tableList.find(item => val == item.tableName )
    form.codeForm.tableComment = table.tableComment
    form.codeForm.tableSchema = table.tableSchema
  }

  const onSubmit = async (formEl: FormInstance | undefined) => {
    if (!formEl) return;
    await formEl.validate((valid)=>{
      if(valid){
        execute(form.codeForm).then(res=>{
          if(res){
            ElMessage.success("添加成功！");
            onCodeGenPage()
          }
        })
        form.codeVisible = false
      }
    })
  }

</script>
<template>
  <div class="codegen-container">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="table.page" :loading="table.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange">
      <template #search>
        <div><el-button type="primary" @click="onAdd">添加</el-button></div>
        <div><el-input v-model="searchForm.tableName" placeholder="请输入表名"></el-input></div>
        <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
        <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onDelete(scope)" type='primary' link style="color:var(--delete); padding:0;">删除</el-button>
      </template>
    </Table>
    <el-dialog title="代码生成" v-model="form.codeVisible" :show-close="false" width="50%">
      <el-form :model="form.codeForm" ref="formRef" :rules="rules" label-width="80px" status-icon>
        <el-tabs v-model="form.tabsActive" tab-position="left" @tab-click="onTabsClick">
          <el-tab-pane name="table" label="表信息">
            <el-form-item label="表名" prop="tableName" :rules="[{required: true,message:'请选择表',trigger: 'change'}]">
              <el-select v-model="form.codeForm.tableName" @change="onTablechange" placeholder="请选表" style="width: 100%">
                <el-option v-for="item in form.tableList" :key="item.tableName" :label="item.tableName" :value="item.tableName">
                  <span style="float: left">{{ item.tableName }}</span>
                  <span style="float: right;color: var(--el-text-color-secondary);">{{ item.tableComment }}</span>
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="描述" prop="tableComment" :rules="[{required: true,message:'请输入描述',trigger: 'blur'}]">
              <el-input v-model="form.codeForm.tableComment" placeholder="请输入描述" style="width: 100%"/>
            </el-form-item>
            </el-tab-pane>
          <el-tab-pane name="column" label="字段信息">
            
          </el-tab-pane>
          <el-tab-pane name="code" label="生成信息">
            
          </el-tab-pane>
        </el-tabs>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
            <el-button @click="form.codeVisible = false">取消</el-button>
            <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>
<style lang="scss" scoped>
  .codegen-container{
    
  }
</style>