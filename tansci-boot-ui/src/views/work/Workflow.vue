<script setup lang="ts">
    import {onMounted, reactive, ref} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import Table from '@/components/Table.vue'
    import BpmnViewer from "@/components/bpmn/BpmnViewer.vue"
    import {useRouter} from 'vue-router'
    import {page,update,del} from '@/api/work/workflow'

    const router = useRouter()
    const searchForm = reactive({
        name: null
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
        onPage();
    }
    function onCurrentChange(e){
        table.page.current = e;
        onPage();
    }
    function onRefresh(){
        searchForm.name = null
        onPage();
    }
    function onSearch(){
        onPage();
    }

    function onSwitchChange(row:any){
        update({
            id: row.id,
            status: row.status
        }).then(res=>{
            if(res){
                ElMessage.success('操作成功！');
                onPage();
            }
        });
    }

    // 添加
    function onAdd(){
        router.push({
            path: '/work/WorkflowAdd',
            query: { id: null }
        });
    }

     // 编辑
    function onEdit(val:any){
        router.push({
            path: '/work/WorkflowAdd',
            query: { id: val.column.row.id }
        });
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
                    onPage();
                }
            })
        }).catch(e=>{
            console.log(e)
        })
    }

    // 预览
    const viewer = reactive({
        viewerVisible: false,
        xmlStr: ''
    })

    function onViewer(val:any){
        viewer.xmlStr = val.column.row.content;
        viewer.viewerVisible = true;
    }

</script>
<template>
    <div class="workflow-container">
        <Table :data="table.tableData" :column="table.tableTitle" :operation="table.operation" :page="table.page" :loading="table.loading"
            @onSizeChange="onSizeChange" @onCurrentChange="onCurrentChange" @onSwitchChange="onSwitchChange">
            <template #search>
                <div><el-button v-permission="'workflow:save'" type="primary" @click="onAdd()">添加</el-button></div>
                <div><el-input v-model="searchForm.name" placeholder="请输入名称"></el-input></div>
                <div><el-button @click="onRefresh" icon="RefreshRight" circle></el-button></div>
                <div><el-button @click="onSearch" type="primary" icon="Search">查询</el-button></div>
            </template>
            <template #column="scope">
                <el-button @click="onViewer(scope)" type='primary' link style="color:var(--query); padding:0;">预览</el-button>
                <el-button @click="onEdit(scope)" v-permission="'workflow:update'" type='primary' link style="color:var(--edit); padding:0;">编辑</el-button>
                <el-button @click="onDelete(scope)" v-permission="'workflow:delete'" type='primary' link style="color:var(--delete); padding:0;">删除</el-button>
            </template>
        </Table>
        <el-dialog v-model="viewer.viewerVisible" title="预览">
            <BpmnViewer :xmlStr="viewer.xmlStr" />
        </el-dialog>
    </div>
</template>
<style lang="scss" scoped>
    .workflow-container{

    }
</style>