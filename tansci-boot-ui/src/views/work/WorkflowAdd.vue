<script setup lang="ts">
    import {onMounted, reactive, ref} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import BpmnModeler from "@/components/bpmn/BpmnModeler.vue"
    import { useRoute, useRouter  } from 'vue-router'
    import { details, save, update } from '@/api/work/workflow'

    const route = useRoute()
    const router = useRouter()
    const formRef = ref<FormInstance>();
    const saveXml = ref(null);
    const form = reactive({
        loading: false,
        workflowForm:{
            id: '',
            name: '',
            content: null,
            status: null,
            remarks: '',
        }
    })

    onMounted(()=>{
        onDetails()
    })

    function onDetails(){
        if(!route.query.id){
            return false;
        }
        form.loading = true;
        details({id: route.query.id}).then((res:any) =>{
            form.workflowForm = {
                id: res.result.id,
                name: res.result.name,
                content: res.result.content,
                status: res.result.status,
                remarks: res.result.remarks,
            }
            form.loading = false;
        })
    }

    function goBack(){
        router.push({path: '/work/Workflow'});
    }

    async function onSubmit(formEl: FormInstance | undefined) {
        if (!formEl) return;
        await formEl.validate((valid)=>{
            if(valid){
                const bpmnModeler = saveXml.value.bpmnModeler;
                if(!bpmnModeler){
                    ElMessage.warning("流程图不能为空！")
                    return false;
                }
                bpmnModeler.saveXML({ format: true }).then((res:any) =>{
                    if(!res.xml){
                        ElMessage.warning("流程图不能为空！")
                        return false;
                    }
                    form.workflowForm.content = res.xml;
                    if(!form.workflowForm.id){
                        save(form.workflowForm).then(res=>{
                            if(res){
                                ElMessage.success("添加成功！");
                                router.push({path: '/work/Workflow'});
                            }
                        })
                    } else {
                        update(form.workflowForm).then(res=>{
                            if(res){
                                ElMessage.success("更新成功！");
                                router.push({path: '/work/Workflow'});
                            }
                        })
                    }
                })
            }
        })
    }

</script>
<template>
    <div class="workflow-add-container">
        <el-form :model="form.workflowForm" ref="formRef" :rules="rules" label-position="left" status-icon>
            <el-row :gutter="20">
                <el-col :span="1">
                    <el-button @click="goBack()">返回</el-button>
                </el-col>
                <el-col :span="7">
                    <el-form-item label="流程名称" prop="name" :rules="[{required: true,message:'请输入名称',trigger: 'blur'}]">
                        <el-input v-model="form.workflowForm.name" placeholder="请输入名称" style="width: 100%"/>
                    </el-form-item>
                </el-col>
                <el-col :span="16">
                    <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="24">
                    <BpmnModeler v-if="!form.loading" :xmlStr="form.workflowForm.content" ref="saveXml"/>
                </el-col>
            </el-row>
        </el-form>
    </div>
</template>
<style lang="scss" scoped>
    .workflow-add-container{

    }
</style>