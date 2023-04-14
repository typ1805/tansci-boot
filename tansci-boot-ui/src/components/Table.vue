<script setup lang="ts">
    import {defineProps, reactive, toRefs} from 'vue'
    import common from '@/utils/common'
    
    const prop = defineProps({
        loading: {
            type: Boolean,
            default: false
        },
        page: {
            type: Object,
            default:{
                current: 1,
                size: 10,
                total: 0,
            }
        }, 
        column: {
            type: Array,
            default: []
        },
        operation: {
            type: Object,
            default: {
                isShow: false,
                width: '220'
            }
        }, 
        tableHeight: {
            type: Number,
            default: null
        },
        headerCellStyle: {
            type: Object,
            default:{color:'#606266', fontWeight: 700}
        },
        data: {
            type: Array,
            default: []
        },
    })

    const emit = defineEmits([
        'onSizeChange','onCurrentChange','onSelectionChange','setCellColor',
        'onButtonClick','onSwitchChange',
    ])

    const state = reactive({
        maxHeight: window.innerHeight - 280,
        tableHeight: prop.tableHeight,
        headerCellStyle: prop.headerCellStyle,
        cellStyle: function(e){
            let obj:any = {};
            emit('setCellColor', e, (color = {}) =>{
                obj = color;
            });
            obj.padding = '2px';
            return obj;
        },
    })
    const {
        maxHeight,tableHeight,headerCellStyle,cellStyle,
    } = toRefs(state)

    const onSizeChange = (e) =>{
        emit('onSizeChange', e)
    }
    const onCurrentChange = (e) =>{
        emit('onCurrentChange', e)
    }

    function onFind(arr:any,val:any){
        if(!arr) return 'info';
        return arr.find(v=>{ return v.value == val}).label;
    }
</script>
<template>
    <div class="table-container">
        <div class="search-wrap">
            <slot name="search"></slot>
        </div>
        <div class="table-wrap">
            <el-table :data="data" border stripe size="mini" :height="tableHeight" :max-height="maxHeight" row-key="id" :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
                v-loading="loading" :header-cell-style="headerCellStyle" :cell-style="cellStyle" 
                @selection-change="onSelectionChange" style="width: 100%;">
                <template v-for="item in column" :key="item">
                    <el-table-column v-if="!item.prop && !item.label" :fixed="item.fixed" type="selection" width="45"></el-table-column>
                    <!-- color值 -->
                    <el-table-column v-else-if="item.type == 'color'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <span :style="{color: scope.row[item.prop]}">{{scope.row[item.prop]}}</span>
                        </template>
                    </el-table-column>
                    <!-- icon图标 -->
                    <el-table-column v-else-if="item.type == 'icon'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-icon :size="20">
                                <component :is="scope.row[item.prop]"></component>
                            </el-icon>
                        </template>
                    </el-table-column>
                    <!-- el-statistic -->
                    <el-table-column v-else-if="item.type == 'statistic'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-statistic :value="scope.row[item.prop]" 
                            :precision="item.option.precision" 
                            :formatter="item.option.formatter"
                            :prefix="item.option.prefix" 
                            :suffix="item.option.suffix"/>
                        </template>
                    </el-table-column>
                    <!-- el-image -->
                    <el-table-column v-else-if="item.type == 'image'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-image :src="scope.row[item.prop]" :preview-src-list="[scope.row[item.prop]]" :z-index="9999" fit="cover" style="width: 50px; height: 50px"/>
                        </template>
                    </el-table-column>
                    <!-- el-rate -->
                    <el-table-column v-else-if="item.type == 'rate'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-rate v-model="scope.row[item.prop]" disabled allow-half />
                        </template>
                    </el-table-column>
                    <!-- el-tag -->
                    <el-table-column v-else-if="item.type == 'tag'" show-overflow-tooltip
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-tag :size="item.option.size" 
                                :effect="item.option.effect" 
                                :type="onFind(item.option.typeList, scope.row[item.prop])">
                                {{scope.row[item.alias==null?item.prop:item.alias]}}    
                            </el-tag>
                        </template>
                    </el-table-column>
                    <!-- el-button -->
                    <el-table-column v-else-if="item.type == 'button'" show-overflow-tooltip
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-button @click="$emit('onButtonClick',scope.row)" :type="item.option.type" link :size="item.option.size">
                                {{scope.row[item.alias==null?item.prop:item.alias]}}    
                            </el-button>
                        </template>
                    </el-table-column>
                    <!-- el-switch -->
                    <el-table-column v-else-if="item.type == 'switch'" show-overflow-tooltip 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-switch @change="$emit('onSwitchChange',scope.row)" :inline-prompt="item.option.inlinePrompt?false:true"
                                :active-value="item.option.activeValue" :active-color="item.option.activeColor" :active-text="item.option.activeText" 
                                :inactive-value="item.option.inactiveValue" :inactive-color="item.option.inactiveColor" :inactive-text="item.option.inactiveText"
                                :size="item.option.size"
                                v-model="scope.row[item.prop]"
                            ></el-switch>
                        </template>
                    </el-table-column>
                    <!-- el-progress  -->
                    <el-table-column v-else-if="item.type == 'progress'" show-overflow-tooltip 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-progress :percentage="scope.row[item.alias==null?item.prop:item.alias]" 
                            :status="item.option.status"
                            :color="item.option.color"/>
                        </template>
                    </el-table-column>
                    <!-- 字典值  -->
                    <el-table-column v-else-if="item.type == 'dict'" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <span>{{common.getDictLabel(item.dictType, scope.row[item.prop])}}</span>
                        </template>
                    </el-table-column>
                    <!-- 其他数据列 -->
                    <el-table-column v-else show-overflow-tooltip 
                        :prop="item.alias==null?item.prop:item.alias" 
                        :label="item.label" 
                        :align="item.align != null ? item.align : 'center'" 
                        :width="item.width"
                        :fixed="item.fixed"
                        :formatter="item.function">
                    </el-table-column>
                </template>
                <!-- 自定义插槽  -->
                <el-table-column v-if="operation.isShow" fixed="right" label="操作" align="center" :width="operation.width">
                    <template #default="scope">
                        <slot name="column" v-bind:column="scope"></slot>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div class="pagination-wrap" v-if="page">
            <el-pagination @size-change="onSizeChange" @current-change="onCurrentChange"
            layout="total, sizes, prev, pager, next, jumper"
            :current-page="page.current"
            :page-sizes="[10, 20, 50, 100]"
            :page-size="page.size"
            :total="page.total"/>
        </div>
    </div>
</template>
<style scoped lang="scss">
</style>