<script setup lang="ts">
    import {onMounted, reactive, ref} from 'vue'
    import {ElMessage, ElMessageBox} from 'element-plus'
    import type {FormInstance} from 'element-plus'
    import BpmnModeler from "@/components/bpmn/BpmnModeler.vue"
    import common from "@/utils/common"
    import { useRoute, useRouter  } from 'vue-router'
    import { details, save, update } from '@/api/work/model'

    const route = useRoute()
    const router = useRouter()
    const formRef = ref<FormInstance>();
    const saveXml = ref(null);
    const form = reactive({
        loading: false,
        modelForm:{
            id: '',
            code: 'code-' + common.uuid(),
            name: '默认模型',
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
            form.modelForm = {
                id: res.result.id,
                code: res.result.code,
                name: res.result.name,
                content: res.result.content,
                status: res.result.status,
                remarks: res.result.remarks,
            }
            form.loading = false;
        })
    }

    function goBack(){
        router.push({path: '/work/Model'});
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
                    form.modelForm.content = res.xml;
                    if(!form.modelForm.id){
                        save(form.modelForm).then(res=>{
                            if(res){
                                ElMessage.success("添加成功！");
                                router.push({path: '/work/Model'});
                            }
                        })
                    } else {
                        update(form.modelForm).then(res=>{
                            if(res){
                                ElMessage.success("更新成功！");
                                router.push({path: '/work/Model'});
                            }
                        })
                    }
                })
            }
        })
    }

</script>
<template>
    <div class="model-add-container">
        <el-form :model="form.modelForm" ref="formRef" :rules="rules" label-position="left" status-icon>
            <el-row :gutter="20">
                <el-col :span="1">
                    <el-button @click="goBack()">返回</el-button>
                </el-col>
                <el-col :span="6">
                    <el-form-item label="流程名称" prop="name" :rules="[{required: true,message:'请输入名称',trigger: 'blur'}]">
                        <el-input v-model="form.modelForm.name" placeholder="请输入名称" style="width: 100%"/>
                    </el-form-item>
                </el-col>
                <el-col :span="6">
                    <el-form-item label="流程编码" prop="code" :rules="[{required: true,message:'请输入编码',trigger: 'blur'}]">
                        <el-input v-model="form.modelForm.code" placeholder="请输入编码" style="width: 100%"/>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-button type="primary" @click="onSubmit(formRef)">提交</el-button>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="24">
                    <BpmnModeler v-if="!form.loading" :code="form.modelForm.code" :name="form.modelForm.name" :xmlStr="form.modelForm.content" ref="saveXml"/>
                </el-col>
            </el-row>
        </el-form>
    </div>
</template>
<style lang="scss" scoped>
    .model-add-container{

    }
</style>