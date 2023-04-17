<script setup lang="ts">
  import { reactive, onMounted, getCurrentInstance } from "vue"
  import Table from '@/components/Table.vue'
  import { page } from "@/api/monitor/operLog"

  const { proxy } = getCurrentInstance()
  const state = reactive({
    loading: false,
    page: {
      current: 1,
      size: 10,
      total: 1,
    },
    operation:{
      isShow: true,
      width: '80'
    },
    tableTitle: [
      {prop:'module',label:'功能模块'},
      {prop:'message',label:'操作描述'},
      {prop:'type',label:'操作类型',type:'tag',option:{size:'small',effect:'plain',typeList:[
        {value: 'INSERT', label: 'success'},
        {value: 'UPDATE', label: 'warning'},
        {value: 'DELETE', label: 'danger'},
        {value: 'SELECT', label: 'info'},
        ]}
      },
      {prop:'takeUpTime',label:'耗时(ms)'},
      {prop:'status',label:'状态', type:'dict',dictType: 'oper_log_status'},
      {prop:'method',label:'操作方法'},
      {prop:'uri',label:'请求URI'},
      {prop:'ip',label:'请求IP'},
      {prop:'userName',label:'用户名称'},
      {prop:'createTime',label:'创建时间'}
    ],
    tableData:[],
    detailVisible: false,
    detail:{},
  })

  onMounted(()=>{
    operLogPage()
  })

  function operLogPage(){
    state.loading = true;
    page(state.page).then((res:any)=>{
      if(res){
        state.loading = false;
        state.tableData = res.result.records;
        state.page.current = res.result.current;
        state.page.size = res.result.size;
        state.page.total = res.result.total;
      }
    })
  }

  function onSizeChange(e){
    state.page.size = e;
    operLogPage();
  }
  function onCurrentChange(e){
    state.page.current = e;
    operLogPage();
  }

  function onDetail(val:any){
    state.detail = val.column.row;
    state.detailVisible = true;
  }

  function setCellColor(e, callback){
    /**
     * e.row：表格那一行的数据
     * e.column：表格单元格那一列的信息
     */ 
    if(e.row.status == '失败' && e.column.property === 'status'){
      callback({color: 'var(--delete)', fontWeight: '700'});
    } else if(e.column.property === 'takeUpTime'){
       callback({color: 'var(--delete)'});
    } else {
      callback({});
    }
  }

</script>
<template>
  <el-card class="operlog-container" :shadow="proxy.$global.cardShadow">
    <Table :data="state.tableData" :column="state.tableTitle" :operation="state.operation" :page="state.page" :loading="state.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange" @setCellColor="setCellColor">
      <template #column="scope">
        <el-button @click="onDetail(scope)" type='primary' text='primary' style="color:var(--theme); padding:0;">详情</el-button>
      </template>
    </Table>
    <el-dialog v-model="state.detailVisible" title="日志详情" :show-close="false" width="60%">
      <el-descriptions :column="3" border>
        <el-descriptions-item label-align="right" label="功能模块" :min-width="80">{{state.detail.module}}</el-descriptions-item>
        <el-descriptions-item label-align="right" label="操作状态">
          <el-tag v-if="state.detail.status == '1'" type="danger">异常</el-tag>
          <el-tag v-else type="success">成功</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label-align="right" label="耗时">
          <span style="color:red;">{{state.detail.takeUpTime}} ms</span>
        </el-descriptions-item>
        <el-descriptions-item label-align="right" label="操作描述">{{state.detail.message}}</el-descriptions-item>
        <el-descriptions-item label-align="right" label="操作类型">
          <el-tag v-if="state.detail.type == 'SELECT'">{{state.detail.type}}</el-tag>
          <el-tag v-else-if="state.detail.type == 'INSERT'" type="success">{{state.detail.type}}</el-tag>
          <el-tag v-else-if="state.detail.type == 'UPDATE'" type="warning">{{state.detail.type}}</el-tag>
          <el-tag v-else-if="state.detail.type == 'DELETE'" type="danger">{{state.detail.type}}</el-tag>
          <el-tag v-else type="info">{{state.detail.type}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label-align="right" label="操作用户">{{state.detail.userName}}</el-descriptions-item>
        <el-descriptions-item label-align="right" label="请求URL">{{state.detail.uri}}</el-descriptions-item>
        <el-descriptions-item label-align="right" label="请求IP">{{state.detail.ip}}</el-descriptions-item>
        <el-descriptions-item label-align="right" label="创建时间">{{state.detail.createTime}}</el-descriptions-item>
        <el-descriptions-item label-align="right" :span="3" label="操作方法">{{state.detail.method}}</el-descriptions-item>
        <el-descriptions-item label-align="right" :span="3" label="请求参数">
          <div class="detail-text scroll-div">{{state.detail.reqParam}}</div>
        </el-descriptions-item>
        <el-descriptions-item v-if="state.detail.status == '0'" label-align="right" :span="3" label="响应参数">
          <div class="detail-text scroll-div">{{state.detail.resParam}}</div>
        </el-descriptions-item>
        <el-descriptions-item v-if="state.detail.status == '1'" label-align="right" :span="3" label="异常信息">
          <div class="detail-text scroll-div">{{state.detail.unusual}}</div>
        </el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </el-card>
</template>
<style lang="scss" scoped>
  .operlog-container{
    .detail-text{
      max-height: 400px;
      overflow: auto;
    }
    .el-descriptions__label{
      width: 80px;
    }
  }
</style>