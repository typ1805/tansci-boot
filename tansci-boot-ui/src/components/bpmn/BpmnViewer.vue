<script setup lang="ts">
    import { onMounted, reactive, ref } from 'vue'
    import BpmnViewer from "bpmn-js/lib/Viewer.js"

    const bpmnViewer = ref();
    const viewerCanvas = ref();
    const props = defineProps({
        xmlStr: {
            type: String,
            default: null
        }
    })

    onMounted(()=>{
        onViewerInit()
    })

    function onViewerInit() {
        console.log(1111111)
        // 初始时清除图层
        if(bpmnViewer && bpmnViewer.value){
            bpmnViewer && bpmnViewer.value.destroy();
            viewerCanvas.value.innerHTML = "";
        }

        // 初始化
        bpmnViewer.value = new BpmnViewer({
            container: viewerCanvas.value,
            height: 520,
        })

        let xmlStr:string = props.xmlStr;
        bpmnViewer.value.importXML(xmlStr).then(() => {
            console.log("success");
            bpmnViewer.value.get("canvas").zoom("fit-viewport");
        }).catch((error:any) => {
            console.log(error);
        });
    }

</script>
<template>
    <div class="bpmn-viewer-container">
        <div id="container" ref="viewerCanvas"></div>
    </div>
</template>
<style lang="scss">
    .bpmn-viewer-container{
        background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImEiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTTAgMTBoNDBNMTAgMHY0ME0wIDIwaDQwTTIwIDB2NDBNMCAzMGg0ME0zMCAwdjQwIiBmaWxsPSJub25lIiBzdHJva2U9IiNlMGUwZTAiIG9wYWNpdHk9Ii4yIi8+PHBhdGggZD0iTTQwIDBIMHY0MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZTBlMGUwIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2EpIi8+PC9zdmc+') repeat !important;
        width:100%;
        height:100%;
        .bjs-powered-by {
            display: none;
        }
    }
</style>