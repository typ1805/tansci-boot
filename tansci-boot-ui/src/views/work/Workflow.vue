<script setup lang="ts">
    import {onMounted, reactive, ref} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import Table from '@/components/Table.vue'
    import {getTaskByAssignee,deployProcess,startProcessInstance,approveTask,rejectTask} from '@/api/work/workflow'

    const table = reactive({
        loading: false,
        operation:{
            isShow: true,
            width: '240'
        },
        tableTitle: [
            {prop:'name',label:'流程名称'},
            {prop:'status',label:'是否禁用',type:'switch',
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
        onPage()
    })

    function onPage(){
        table.loading = true;
        getTaskByAssignee({assignee: '6cfc6a42-0984-11f0-82ff-4ccc6a2e3718'}).then((res:any)=>{
            if(res){
                console.log(res)
                table.loading = false;
            }
        })
    }

    // 删除
    function onDelete(val:any){
        ElMessageBox.confirm('此操作将永久删除, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            // del(val.column.row.id).then(res=>{
            //     if(res){
            //         ElMessage.success('删除成功!');
            //         onPage();
            //     }
            // })
        }).catch(e=>{
            console.log(e)
        })
    }

</script>
<template>
    <div class="workflow-container">
        <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :loading="table.loading">
            <template #search>
            </template>
            <template #column="scope">
                <el-button @click="onDelete(scope)" v-permission="'workflow:delete'" type='primary' link style="color:var(--delete); padding:0;">删除</el-button>
            </template>
        </Table>
    </div>
</template>
<style lang="scss" scoped>
    .workflow-container{

    }
</style>