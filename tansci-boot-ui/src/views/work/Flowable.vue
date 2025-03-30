<script setup lang="ts">
    import {onMounted, reactive, ref} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import Table from '@/components/Table.vue'
    import {modelList,processDefinitionList,activateProcess,suspendProcess,deleteDeployment,deleteProcessInstance,taskList,deployProcess,startProcessInstance,approveTask,rejectTask} from '@/api/work/workflow'

    const state = reactive({
        tabsActive: 'process',
        tabs: [
            {id: 'process', name: '流程定义'},
            {id: 'tasks', name: '任务管理'},
            {id: 'model', name: '模型列表'},
        ]
    })

    onMounted(()=>{
        onTabClick(null);
    })

    function onTabClick(tab: any){
        table.loading = true;
        if(tab && tab.props.name == 'process'){
            processDefinitionList({}).then((res:any)=>{
                if(res){
                    console.log(res)
                    table.loading = false;
                }
            })
        } else if(tab && tab.props.name == 'tasks'){
            taskList({}).then((res:any)=>{
                if(res){
                    console.log(res)
                    table.loading = false;
                }
            })
        } else if(tab && tab.props.name == 'model'){
            modelList({}).then((res:any)=>{
                if(res){
                    console.log(res)
                    table.loading = false;
                }
            })
        } else {
            processDefinitionList({}).then((res:any)=>{
                if(res){
                    console.log(res)
                    table.loading = false;
                }
            })
        }
    }

    const table = reactive({
        loading: false,
        operation:{
            isShow: true,
            width: '240'
        },
        tableTitle: [
            {prop:'name',label:'流程名称'},
            {prop:'updateTime',label:'更新时间'},
            {prop:'remarks',label:'描述'}
        ],
        tableData:[],
    })


</script>
<template>
    <div class="flowable-container">
        <el-tabs v-model="state.tabsActive" @tab-click="onTabClick">
            <el-tab-pane v-for="item in state.tabs" :key="item.id" :label="item.name" :name="item.id">
                <Table :data="table.tableData" :column="table.tableTitle" :page="null" :operation="table.operation" :loading="table.loading">
                    <template #column="scope">
                        <el-button type='primary' link style="color:var(--delete); padding:0;">TODO</el-button>
                    </template>
                </Table>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<style lang="scss" scoped>
    .flowable-container{

    }
</style>