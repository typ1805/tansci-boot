<script setup lang="ts">
  import { reactive, onMounted, ref } from "vue"
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import { page, del, save, execute, tables, columns } from "@/api/lowcode/codeGen"

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
  
  var validatePath = (rule:any, value:any, callback:any) => {
    if(!value.startsWith('/')){
      callback(new Error('请以“/”开头'));
    }else if(value.endsWith('/')){
      callback(new Error('不能以“/”结尾'));
    }else{
      callback();
    }
  }
  const formRef = ref<FormInstance>()
  const form = reactive({
    tableList: [],
    primary:'',
    tabsActive: 'table',
    codeVisible: false,
    templates: [
      { label: '单表（增删改查）', value: 'single' },
      { label: '树表（增删改查）', value: 'tree' },
      { label: '主子表（增删改查）', value: 'subTable' }
    ],
    codeForm: {
      tableName: '',
      dataSource: '',
      tableComment: '',
      info: {
        moduleName: '',
        modulePath: '',
        businessName: '',
        businessPath: '',
        template: 'single',
        pid: '',
        treeId: '',
        treePid: '',
        subTable: '',
        subTableKey: ''
      },
      columns: [],
      subColumns: []
    }
  })

  function onTables(){
    tables({name: 'tansci_boot'}).then((res:any)=>{
      form.tableList = res.result
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
    form.codeForm = {
      tableName: '',
      dataSource: '',
      tableComment: '',
      info: {
        moduleName: '',
        modulePath: '',
        businessName: '',
        businessPath: '',
        template: 'single',
        pid: '',
        treeId: '',
        treePid: '',
        subTable: '',
        subTableKey: ''
      },
      columns: [],
      subColumns: []
    }
    form.codeVisible = true
  }

  function onTablechange(){
    let _table = form.tableList.find(item => form.codeForm.tableName == item.tableName )
    form.codeForm.tableComment = _table.tableComment
    form.codeForm.dataSource = _table.tableSchema
    columns({name: form.codeForm.tableName}).then((res:any)=>{
        // form.codeForm.columns = res.result
        let _columns = res.result
        form.codeForm.columns = []
        _columns.forEach((it:any) => {
            form.codeForm.columns.push({
                columnName: it.columnName.replace(/\_(\w)/g, (all, letter) => letter.toUpperCase()),
                columnComment: it.columnComment,
                columnType: it.columnType,
                component: `component: 'input'`,
                where: '=',
                save: true,
                query: true,
                list: true,
                required: it.required == 1
            })
        })
    })
  }

  function onSubTableChange(){
    columns({name: form.codeForm.info.subTable}).then((res:any)=>{
        // form.codeForm.subColumns = res.result
        let _columns = res.result
        form.codeForm.subColumns = []
        _columns.forEach((it:any) => {
            form.codeForm.subColumns.push({
                columnName: it.columnName.replace(/\_(\w)/g, (all, letter) => letter.toUpperCase()),
                columnComment: it.columnComment,
                columnType: it.columnType,
                component: `component: 'input'`,
                where: '=',
                save: true,
                query: true,
                list: true,
                required: it.required == 1
            })
        })
    })
  }

  const onSubmit = async (formEl: FormInstance | undefined) => {
    if (!formEl) return;
    await formEl.validate((valid)=>{
      if(valid){
        ElMessageBox.confirm('此操作会生成代码并覆盖, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          let formData = new FormData()
          formData.append("tableName", form.codeForm.tableName)
          formData.append("tableComment", form.codeForm.tableComment)
          formData.append("dataSource", form.codeForm.dataSource)
          formData.append("info", JSON.stringify(form.codeForm.info))
          formData.append("columns", JSON.stringify(form.codeForm.columns))
          formData.append("subTableName", form.codeForm.info.subTable)
          formData.append("subColumns", JSON.stringify(form.codeForm.subColumns))
          execute(formData).then((res:any)=>{
            formData.append("interfaceId", res.result)
            save(formData).then((res:any)=>{
              ElMessage.success("添加成功！");
              onCodeGenPage()
              form.codeVisible = false
            })
          })
        })
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
    <el-dialog v-model="form.codeVisible" title="接口生成" :show-close="false" width="60%" >
      <el-form ref="formRef" :model="form.codeForm" :rules="rules" status-icon label-width="100px">
          <div style="padding-bottom: 1rem;">数据源信息</div>
          <el-card shadow="never">
            <el-row :gutter="24">
              <el-col :span="12">
                <el-form-item label="表 名" prop="tableName" :rules="[{ required: true, message: '请选择表', trigger: 'change' }]">
                  <el-select v-model="form.codeForm.tableName" @change="onTablechange()" placeholder="请选择表" style="width:100%">
                    <el-option v-for="item in form.tableList" :key="item.tableName" :label="item.tableName" :value="item.tableName">
                      <span style="float: left">{{ item.tableName }}</span>
                      <span style="float: right;color: var(--el-text-color-secondary);">{{ item.tableComment }}</span>
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="描 述" prop="tableComment" :rules="[{ required: true, message: '请输入描述', trigger: 'change' }]">
                  <el-input v-model="form.codeForm.tableComment" />
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <div style="padding: 1rem ;">生成接口信息</div>
          <el-card shadow="never">
            <el-row :gutter="24">
              <el-col :span="12">
                <el-form-item label="生成模板" prop="info.template" :rules="[{ required: true, message: '请选择模板', trigger: 'change' }]">
                  <el-select v-model="form.codeForm.info.template" placeholder="请选择模板" style="width:100%">
                    <el-option v-for="item in form.templates" :key="item.value" :label="item.label" :value="item.value" />
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12" class="form-describe">
                <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                <span>模板：单表、树表、主子表（增删改查）</span>
              </el-col>
            </el-row>
            <el-row :gutter="24">
              <el-col :span="12">
                <el-form-item prop="info.moduleName" label="模块名称" :rules="[{ required: true, message: '请输入模块名称', trigger: 'change' }]">
                  <el-input v-model="form.codeForm.info.moduleName"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12" class="form-describe">
                <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                <span>模块名称：第一级分组名称，例如：系统功能</span>
              </el-col>
            </el-row>
            <el-row :gutter="24">
              <el-col :span="12">
                <el-form-item prop="info.modulePath" label="模块路径" :rules="[{ required: true, message: '请输入模块路径', trigger: 'change' },  { validator: validatePath }]">
                  <el-input v-model="form.codeForm.info.modulePath"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12" class="form-describe">
                <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                <span>模块路径：第一级分组的路径，例如：/system</span>
              </el-col>
            </el-row>
              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item prop="info.businessName" label="功能名称" :rules="[{ required: true, message: '请输入功能名称', trigger: 'change' }]">
                    <el-input v-model="form.codeForm.info.businessName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="12" class="form-describe">
                  <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                  <span>功能名称：第二级分组名称，例如：菜单管理</span>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item prop="info.businessPath" label="功能路径" :rules="[{ required: true, message: '请输入功能路径', trigger: 'change' },  { validator: validatePath }]">
                    <el-input v-model="form.codeForm.info.businessPath"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="12" class="form-describe">
                  <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                  <span>功能路径：第二级分组路径，例如：/menu</span>
                </el-col>
              </el-row>
              <div v-if="form.codeForm.info.template == 'tree'">
                <el-divider content-position="left">关联信息</el-divider>
                <el-row :gutter="24">
                  <el-col :span="12">
                    <el-form-item prop="info.treeId" label="树编码" :rules="[{ required: true, message: '请选择树编码字段', trigger: 'change' }]">
                        <el-select v-model="form.codeForm.info.treeId" placeholder="请选择树编码字段" style="width:100%">
                          <el-option v-for="item in form.codeForm.columns" :key="item.columnName" :label="item.columnComment" :value="item.columnName">
                            <span style="float: left">{{ item.columnName }}</span>
                            <span style="float: right;color: var(--el-text-color-secondary);">{{ item.columnComment }}</span>
                          </el-option>
                        </el-select>
                    </el-form-item>
                  </el-col>
                  <el-col :span="12" class="form-describe">
                    <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                    <span>树编码：树显示的编码字段名称，例如：id</span>
                  </el-col>
                </el-row>
                <el-row :gutter="24">
                  <el-col :span="12">
                    <el-form-item prop="info.treePid" label="父编码" :rules="[{ required: true, message: '请选择树父编码字段', trigger: 'change' }]">
                      <el-select v-model="form.codeForm.info.treePid" placeholder="请选择树父编码字段" style="width:100%">
                        <el-option v-for="item in form.codeForm.columns" :key="item.columnName" :label="item.columnComment" :value="item.columnName">
                          <span style="float: left">{{ item.columnName }}</span>
                          <span style="float: right;color: var(--el-text-color-secondary);">{{ item.columnComment }}</span>
                        </el-option>
                      </el-select>
                    </el-form-item>
                  </el-col>
                  <el-col :span="12" class="form-describe">
                    <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                    <span>树父编码：树显示的父编码字段名称，例如：pid</span>
                  </el-col>
                </el-row>
              </div>
              <div v-if="form.codeForm.info.template == 'subTable'">
                <el-divider content-position="left">关联信息</el-divider>
                <el-row :gutter="24">
                  <el-col :span="12">
                    <el-form-item prop="info.subTable" label="关联子表名" :rules="[{ required: true, message: '请选择关联子表名称', trigger: 'change' }]">
                      <el-select v-model="form.codeForm.info.subTable" @change="onSubTableChange()" placeholder="请选择表" style="width:100%">
                        <el-option v-for="item in form.tableList" :key="item.tableName" :label="item.tableComment" :value="item.tableName">
                          <span style="float: left">{{ item.tableName }}</span>
                          <span style="float: right;color: var(--el-text-color-secondary);">{{ item.tableComment }}</span>
                        </el-option>
                      </el-select>
                    </el-form-item>
                  </el-col>
                  <el-col :span="12" class="form-describe">
                    <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                    <span>关联子表名：关联字表的名称，例如：sys_menu_role</span>
                  </el-col>
                </el-row>
                <el-row :gutter="24">
                  <el-col :span="12">
                    <el-form-item prop="info.subTableKey" label="子表外键名" :rules="[{ required: true, message: '请选择子表关联的外键名', trigger: 'change' }]">
                      <el-select v-model="form.codeForm.info.subTableKey" placeholder="请选择子表关联的外键名" style="width:100%">
                        <el-option v-for="item in form.codeForm.subColumns" :key="item.columnName" :label="item.columnComment" :value="item.columnName">
                          <span style="float: left">{{ item.columnName }}</span>
                          <span style="float: right;color: var(--el-text-color-secondary);">{{ item.columnComment }}</span>
                        </el-option>
                      </el-select>
                    </el-form-item>
                  </el-col>
                  <el-col :span="12" class="form-describe">
                    <el-icon style="vertical-align: middle; padding-right: 0.2rem"><ElIconInfoFilled /></el-icon>
                    <span>子表关联的外键名：子表关联的外键名，例如：menu_id</span>
                  </el-col>
                </el-row>
              </div>
          </el-card>
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