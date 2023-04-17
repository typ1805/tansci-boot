<script setup lang="ts">
  import {onMounted, reactive, ref, unref, getCurrentInstance} from 'vue'
  import {ElMessage, ElMessageBox} from 'element-plus'
  import type {FormInstance} from 'element-plus'
  import Table from '@/components/Table.vue'
  import {page,save,update,del,roleList} from '@/api/system/user'
  
  const { proxy } = getCurrentInstance()
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
      width: '240'
    },
    tableTitle: [
      {prop:'',label:'',fixed:'left'},
      {prop:'username',label:'用户名称'},
      {prop:'nickname',label:'用户昵称'},
      {prop:'type',label:'用户类型',type:'dict',dictType:'user_type'},
      {prop:'avatar',label:'头像'},
      {prop:'phone',label:'手机号'},
      {prop:'gender',label:'性别',type:'dict',dictType:'user_gender'},
      {prop:'birthday',label:'出生日期'},
      {prop:'email',label:'邮箱'},
      {prop:'address',label:'地址'},
      {prop:'isLogin',label:'是否禁用',type:'switch',
        option:{
          activeValue:0,activeColor:'#13ce66',activeText:'启用',
          inactiveValue:1,inactiveColor:'#ff4949',inactiveText:'禁用',
          inlinePrompt: false
        }
      },
      {prop:'updateTime',label:'更新时间'},
      {prop:'remarks',label:'描述'}
    ],
    tableData:[],
  })

  onMounted(()=>{
    onUserPage()
  })

  function onUserPage(){
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
    onUserPage();
  }
  function onCurrentChange(e){
    table.page.current = e;
    onUserPage();
  }
  function onRefresh(){
    searchForm.username = null
    onUserPage();
  }
  function onSearch(){
    onUserPage();
  }

  function onSwitchChange(row:any){
    update({
      id: row.id,
      isLogin: row.isLogin
    }).then(res=>{
      if(res){
        ElMessage.success('操作成功！');
        onUserPage();
      }
    });
  }

  const formRef = ref<FormInstance>();
  const form = reactive({
    userVisible: false,
    roleList: [],
    operate: 0,
    userForm:{
      id:'',
      username:'',
      password: '',
      rePassword: '',
      nickname: '',
      type: null,
      phone: '',
      avatar: '',
      gender: '',
      birthday: '',
      address: '',
      email: '',
      remarks: '',
      orgId: '',
      roleId: ''
    },
  })

  const validatePass = (rule, value, callback) => {
    if (value === '') {
      callback(new Error('请输入确认密码'));
    } else if (value !== form.userForm.password) {
      callback(new Error('两次输入密码不一致!'));
    } else {
      callback();
    }
  }

  function onRoleList(){
    roleList().then((res:any)=>{
      form.roleList = res.result
    })
  }

  // 添加信息
  function onAddRole(){
    form.operate = 0
    form.userForm = {
      id:'',
      username:'',
      password: '',
      rePassword: '',
      nickname: '',
      type: null,
      phone: '',
      avatar: '',
      gender: '',
      birthday: '',
      address: '',
      email: '',
      remarks: '',
      orgId: '',
      roleId: ''
    }
    onRoleList()
    form.userVisible = true
  }
  // 编辑
  function onEdit(val:any){
    form.operate = 1
    form.userForm = {
      id: val.column.row.id,
      username: val.column.row.username,
      nickname: val.column.row.nickname,
      type: val.column.row.type,
      phone: val.column.row.phone,
      avatar: val.column.row.avatar,
      gender: val.column.row.gender,
      birthday: val.column.row.birthday,
      address: val.column.row.address,
      email: val.column.row.email,
      remarks: val.column.row.remarks,
      orgId: val.column.row.orgId,
      roleId: val.column.row.roleId
    }
    onRoleList()
    form.userVisible = true
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
          onUserPage();
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
          save(form.userForm).then(res=>{
            if(res){
              ElMessage.success("添加成功！");
              onUserPage()
            }
          })
        } else {
          update(form.userForm).then(res=>{
            if(res){
              ElMessage.success("更新成功！");
              onUserPage()
            }
          })
        }
        form.operate = 0
        form.userVisible = false
      }
    })
  }

</script>
<template>
  <el-card class="user-container" :shadow="proxy.$global.cardShadow">
    <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="table.page" :loading="table.loading"
      @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange" @onSwitchChange="onSwitchChange">
      <template #search>
        <div><el-button type="primary" @click="onAddRole">添加</el-button></div>
        <div><el-input v-model="searchForm.username" placeholder="请输入名称"></el-input></div>
        <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
        <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
      </template>
      <template #column="scope">
        <el-button @click="onEdit(scope)" type='primary' text='primary' style="color:var(--edit); padding:0;">编辑</el-button>
        <el-button @click="onDelete(scope)" type='primary' text='primary' style="color:var(--delete); padding:0;">删除</el-button>
      </template>
    </Table>
    <el-dialog title="用户信息" v-model="form.userVisible" :show-close="false" width="50%">
        <el-form :model="form.userForm" ref="formRef" :rules="rules" label-width="80px" status-icon>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="名称" prop="username" :rules="[
                {required: true,message:'请输入名称',trigger: 'blur'},
                {pattern: /^[a-zA-Z]\w{4,17}$/, message: '以字母开头，长度在5~18之间，只能包含字母、数字', trigger: 'blur'}]">
                <el-input v-model="form.userForm.username" placeholder="请输入名称" style="width: 100%"/>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="昵称" prop="nickname" :rules="[{required: true,message:'请输入昵称',trigger: 'blur'}]">
                <el-input v-model="form.userForm.nickname" placeholder="请输入昵称" style="width: 100%"/>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item v-if="form.operate == 0" label="密码" prop="password" :rules="[{required: true, message: '请输入密码', trigger: 'blur'},
                {pattern: /^[a-zA-Z]\w{5,17}$/, message: '以字母开头，长度在6~18之间，只能包含字母、数字和下划线', trigger: 'blur'}]">
                <el-input v-model="form.userForm.password" placeholder="请输入密码" style="width: 100%"/>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item v-if="form.operate == 0" prop="rePassword" label="确认密码" :rules="[{required: true, message: '请输入确认密码', trigger: 'blur'},{validator: validatePass, trigger: 'blur'}]">
                  <el-input v-model="form.userForm.rePassword" type="password" placeholder="请输入确认密码"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="类型" prop="type" :rules="[{required: true,message:'请选择类型',trigger: 'blur'}]">
                <el-radio-group v-model="form.userForm.type">
                  <el-radio :label="1">管理员</el-radio>
                  <el-radio :label="2">普通用户</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="性别" prop="gender">
                <el-radio-group v-model="form.userForm.gender">
                  <el-radio :label="0">男</el-radio>
                  <el-radio :label="1">女</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="电话" prop="phone" :rules="[{pattern: /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/, message: '请输入正确的手机号', trigger: 'blur'}]">
                <el-input v-model="form.userForm.phone" placeholder="请输入电话" style="width: 100%"/>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="生日" prop="birthday">
                <el-date-picker v-model="form.userForm.birthday" type="date" placeholder="选择日期" style="width: 100%;"></el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="地址" prop="address">
                <el-input v-model="form.userForm.address" placeholder="请输入地址" style="width: 100%"/>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="邮箱" prop="email" :rules="[{pattern: /^[a-zA-Z0-9]+([-_.][A-Za-zd]+)*@([a-zA-Z0-9]+[-.])+[A-Za-zd]{2,5}$/, message: '请输入正确邮箱', trigger: 'blur'}]">
                <el-input v-model="form.userForm.email" placeholder="请输入邮箱" style="width: 100%"/>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="角色" prop="roleId" :rules="[{required: true,message:'请选择角色',trigger: 'change'}]">
                <el-select v-model="form.userForm.roleId" placeholder="请选角色" style="width: 100%">
                  <el-option v-for="item in form.roleList" :key="item.id" :label="item.name" :value="item.id" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="描述" prop="remarks">
                <el-input v-model="form.userForm.remarks" type="textarea" placeholder="请输入描述" style="width: 100%"/>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
        <template #footer>
            <span class="dialog-footer">
                <el-button @click="form.userVisible = false">取消</el-button>
                <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
            </span>
        </template>
    </el-dialog>
  </el-card>
</template>
<style scoped lang="scss">
  .user-container{
    
  }
</style>