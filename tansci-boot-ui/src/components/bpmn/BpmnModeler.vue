<script setup lang="ts">
    import { onMounted, reactive, ref } from 'vue'
    import BpmnModeler  from "bpmn-js/lib/Modeler.js"
    import "bpmn-js/dist/assets/diagram-js.css"
    import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
    import "bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css"
    import "bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css"
    import {
        BpmnPropertiesPanelModule,
        BpmnPropertiesProviderModule,
        CamundaPlatformPropertiesProviderModule
    } from "bpmn-js-properties-panel"
    import camundaBpmnModdle from "camunda-bpmn-moddle/resources/camunda.json"
    import translate from './translate/translate.js'

    const bpmnCanvas = ref();
    const bpmnProperties = ref();
    const bpmnModeler = ref();
    const props = defineProps({
        xmlStr: {
            type: String,
            default: null
        },
        isPanel:{
            type: Boolean,
            default: true
        }
    })
    const state = reactive({
        scale: 1.0
    })

    defineExpose({
        bpmnModeler
    })

    onMounted(()=>{
        onModelerInit()
    })

    function onModelerInit() {
        bpmnModeler.value = new BpmnModeler({
            // 基础画布
            container: bpmnCanvas.value,
            //属性面板
            propertiesPanel: {
                parent: bpmnProperties.value,
            },
            additionalModules: [
                BpmnPropertiesPanelModule,
                BpmnPropertiesProviderModule,
                CamundaPlatformPropertiesProviderModule,
                {translate: ["value", translate]},
            ],
            moddleExtensions: {
                camunda: camundaBpmnModdle,
            },
        })

        let xmlStr:string = props.xmlStr;
        if(!props.xmlStr){
            xmlStr = `xml <?xml version="1.0" encoding="UTF-8"?>
                <definitions xmlns="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:omgdc="http://www.omg.org/spec/DD/20100524/DC" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:camunda="http://camunda.org/schema/1.0/bpmn" id="sid-38422fae-e03e-43a3-bef4-bd33b32041b2" targetNamespace="http://bpmn.io/bpmn" exporter="bpmn-js (https://demo.bpmn.io)" exporterVersion="5.1.2">
                <process id="Process" name="默认模板" isExecutable="true" camunda:versionTag="0.0.1">
                </process>
                <bpmndi:BPMNDiagram id="BpmnDiagram_1">
                    <bpmndi:BPMNPlane id="BpmnPlane_1" bpmnElement="Process">
                    <bpmndi:BPMNShape id="StartEvent_1y45yut_di" bpmnElement="StartEvent">
                        <omgdc:Bounds x="152" y="102" width="36" height="36" />
                        <bpmndi:BPMNLabel>
                        <omgdc:Bounds x="160" y="145" width="22" height="14" />
                        </bpmndi:BPMNLabel>
                    </bpmndi:BPMNShape>
                    </bpmndi:BPMNPlane>
                </bpmndi:BPMNDiagram>
                </definitions>`
        }

        bpmnModeler.value.importXML(xmlStr).then(() => {
            console.log("success");
            bpmnModeler.value.get("canvas").zoom("fit-viewport");
        }).catch((error:any) => {
            console.log(error);
        });
    }

    // 保存 XML
    async function onSaveXml() {
        const { xml } = await bpmnModeler.value.saveXML({ format: true });
    }

    // 保存 SVG
    async function onSaveSvg() {
        const { svg } = await bpmnModeler.value.saveSVG();
    }

    // 放大、缩小、还原
    function onHandlerZoom(radio:any) {
        bpmnModeler.value.get("commandStack").undo();
        const newScale = !radio ? 1.0 : state.scale + radio;
        bpmnModeler.value.get('canvas').zoom(newScale);
        state.scale = newScale;
    }

    // 后退
    function onHandleUndo() {
        bpmnModeler.value.get("commandStack").undo();
    }

    // 前进
    function onHandleRedo() {
        bpmnModeler.value.get("commandStack").redo();
    }

    // 下载
    async function onHandleDownload() {
        const { xml } = await bpmnModeler.value.saveXML({ format: true });
        const dataTrack = "bpmn";
        const a = document.createElement("a");
        const name = `diagram.${dataTrack}`;
        a.setAttribute("href",`data:application/bpmn20-xml;charset=UTF-8,${encodeURIComponent(xml)}`);
        a.setAttribute("target", "_blank");
        a.setAttribute("dataTrack", `diagram:download-${dataTrack}`);
        a.setAttribute("download", name);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }

    // 导入
    function onHandleOnchangeFile(file:any) {
        const reader = new FileReader();
        reader.readAsText(file.raw, "utf-8");
        reader.onload = async (event) => {
            await bpmnModeler.value.importXML(event.target.result);
        }
    }
</script>
<template>
    <div class="bpmn-container">
        <div class="bpmn-header">
            <el-button-group size="small">
                <el-tooltip effect="light" content="还原"><el-button icon="Refresh" @click="onHandlerZoom(0)"></el-button></el-tooltip>
                <el-tooltip effect="light" content="放大"><el-button icon="CirclePlus" @click="onHandlerZoom(0.1)"></el-button></el-tooltip>
                <el-tooltip effect="light" content="缩小"><el-button icon="Remove" @click="onHandlerZoom(-0.1)"></el-button></el-tooltip>
                <el-tooltip effect="light" content="撤销"><el-button icon="RefreshLeft" @click="onHandleUndo"></el-button></el-tooltip>
                <el-tooltip effect="light" content="恢复"><el-button icon="RefreshRight" @click="onHandleRedo"></el-button></el-tooltip>
                <el-tooltip effect="light" content="下载"><el-button icon="Download" @click="onHandleDownload"></el-button></el-tooltip>
                <el-tooltip effect="light" content="导入">
                    <el-upload style="display: inline-block" :file-list="fileList" action="" :auto-upload="false" :show-file-list="false" :on-change="onHandleOnchangeFile">
                        <el-button icon="Upload"></el-button>
                    </el-upload>
                </el-tooltip>
            </el-button-group>
        </div>
        <div class="bpmn-mall">
            <!-- 内容区 -->
            <div id="container" ref="bpmnCanvas"></div>
            <!-- 右侧控制区 -->
            <div id="properties" ref="bpmnProperties" v-if="props.isPanel" class="bpmn-panel"></div>
        </div>
    </div>
</template>
<style lang="scss">
    @import './properties-panel.css';
    .bpmn-container{
        background-color: white;
        position: relative;
        height: 85vh;
        .bpmn-header{
            padding-bottom: 0.4rem;
        }
        .bpmn-mall {
            // background-image: linear-gradient(90deg,hsla(0,0%,78.4%,.15) 10%,transparent 0),linear-gradient(hsla(0,0%,78.4%,.15) 10%,transparent 0);
            // background-size: 10px 10px;
            background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImEiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTTAgMTBoNDBNMTAgMHY0ME0wIDIwaDQwTTIwIDB2NDBNMCAzMGg0ME0zMCAwdjQwIiBmaWxsPSJub25lIiBzdHJva2U9IiNlMGUwZTAiIG9wYWNpdHk9Ii4yIi8+PHBhdGggZD0iTTQwIDBIMHY0MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZTBlMGUwIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2EpIi8+PC9zdmc+') repeat !important;
            width:100%;
            height:100%;
            display: grid;
        }
        .bpmn-panel {
            width: 260px;
            position: absolute;
            right: 1px;
            border: 1px solid rgba(0,0,0,0.1);
        }
        /* 右下角logo */
        .bjs-powered-by {
            display: none;
        }
    }
</style>