<script setup lang="ts">
  import { reactive, onMounted, getCurrentInstance } from "vue"
  import Table from '@/components/Table.vue'
  import { page } from "@/api/monitor/loginLog"

  const { proxy } = getCurrentInstance()
  const state = reactive({
    loading: false,
    page: {
      current: 1,
      size: 10,
      total: 1,
    },
    operation:{
      isShow: false,
      width: '80'
    },
    tableTitle: [
      {prop:'username',label:'登录账号'},
      {prop:'type',label:'登录类型'},
      {prop:'browser',label:'浏览器'},
      {prop:'os',label:'操作系统'},
      {prop:'address',label:'地理位置'},
      {prop:'ip',label:'请求IP'},
      {prop:'token',label:'Token'},
      {prop:'failPassword',label:'登录密码'},
      {prop:'message',label:'异常原因'},
      {prop:'createTime',label:'创建时间'}
    ],
    tableData:[],
  })

  onMounted(()=>{
    loginLogPage()
  })

  function loginLogPage(){
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
    loginLogPage();
  }
  function onCurrentChange(e){
    state.page.current = e;
    loginLogPage();
  }

  function setCellColor(e, callback){
    /**
     * e.row：表格那一行的数据
     * e.column：表格单元格那一列的信息
     */ 
    if(e.row.type == '失败' && e.column.property === 'type'){
      callback({color: 'var(--delete)', fontWeight: '700'});
    } else if(e.row.type == '失败' && e.column.property === 'failPassword'){
      callback({color: 'var(--delete)', fontWeight: '700'});
    } else if(e.row.type == '成功' && e.column.property === 'type'){
      callback({color: 'var(--add)', fontWeight: '700'});
    } else {
      callback({});
    }
  }

</script>
<template>
  <el-card class="loginlog-container" :shadow="proxy.$global.cardShadow">
    <Table :data="state.tableData" :column="state.tableTitle" :operation="state.operation" :page="state.page" :loading="state.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange" @setCellColor="setCellColor">
    </Table>
  </el-card>
</template>
<style lang="scss" scoped>
  .loginlog-container{
    
  }
</style>