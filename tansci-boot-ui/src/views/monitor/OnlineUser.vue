<script setup lang="ts">
  import {onMounted, reactive, ref, unref} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import {page,kick} from '@/api/monitor/onlineUser'
  
  const searchForm = reactive({
    username: null
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
      width: '80'
    },
    tableTitle: [
      {prop:'',label:'',fixed:'left'},
      {prop:'username',label:'登录账号'},
      {prop:'address',label:'地理位置'},
      {prop:'ip',label:'请求IP'},
      {prop:'browser',label:'浏览器'},
      {prop:'os',label:'操作系统'},
      {prop:'createTime',label:'登录时间'}
    ],
    tableData:[],
  })

  onMounted(()=>{
    onOnlineUserPage()
  })

  function onOnlineUserPage(){
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
    onOnlineUserPage();
  }
  function onCurrentChange(e){
    table.page.current = e;
    onOnlineUserPage();
  }
  function onRefresh(){
    searchForm.username = null
    onOnlineUserPage();
  }
  function onSearch(){
    onOnlineUserPage();
  }

  function onKick(val:any){
    ElMessageBox.confirm('确定将该用户踢下线吗?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      kick(val.column.row.token).then(res=>{
        if(res){
          ElMessage.success('操作成功!');
          onOnlineUserPage();
        }
      })
    }).catch(e=>{
      console.log(e)
    })
  }

</script>
<template>
  <div class="onlineuser-container">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="table.page" :loading="table.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange">
      <template #search>
        <div><el-input v-model="searchForm.username" placeholder="请输入登录名称"></el-input></div>
        <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
        <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onKick(scope)" link style="color:var(--edit); padding:0;">踢人</el-button>
      </template>
    </Table>
  </div>
</template>
<style scoped lang="scss">
  .onlineuser-container{
    
  }
</style>