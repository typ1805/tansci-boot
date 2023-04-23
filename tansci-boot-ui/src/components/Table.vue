<script setup lang="ts">
    import {defineProps, reactive, toRefs, watch} from 'vue'
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
        size: 'default',
        columns: prop.column.map((item:any) => {return item.prop}),
        checkColAll: true,
        isIndeterminate: true,
        cellStyle: function(e:any){
            let obj:any = {};
            emit('setCellColor', e, (color = {}) =>{
                obj = color;
            });
            obj.padding = '2px';
            return obj;
        },
    })
    const {
        maxHeight,tableHeight,headerCellStyle,cellStyle,size,columns,checkColAll,isIndeterminate 
    } = toRefs(state)

    const onSizeChange = (e:any) =>{
        emit('onSizeChange', e)
    }
    const onCurrentChange = (e:any) =>{
        emit('onCurrentChange', e)
    }

    function onFind(arr:any,val:any){
        if(!arr) return 'info';
        return arr.find((item:any)=>{ return item.value == val}).label;
    }

    function onCheckColAll(val:boolean){
        const _columns = prop.column.map((item:any) => {return item.prop})
        state.columns = val ? _columns : []
        state.isIndeterminate = false
    }
    function onCheckedCol(value: string[]){
        let checkedCount = value.length
        state.checkColAll = checkedCount === prop.column.length
        state.isIndeterminate = checkedCount > 0 && checkedCount < prop.column.length
    }

    watch(columns, (newValue, oldValue) =>{
        prop.column.filter((item:any) =>{
            if(newValue.indexOf(item.prop) != -1){
                item.isShow = false
            }else{
                item.isShow = true
            }
        })
    })

</script>
<template>
    <div class="table-container">
        <div class="search-wrap">
            <slot name="search"></slot>
        </div>
        <div class="table-wrap">
            <div class="header">
                <el-popover placement="bottom" :width="80" trigger="click">
                    <template #reference>
                        <el-button link>
                            <el-icon :size="20"><Sort /></el-icon>
                        </el-button>
                    </template>
                    <div>
                        <el-radio-group v-model="size">
                            <el-radio label="small">紧凑</el-radio>
                            <el-radio label="default">默认</el-radio>
                            <el-radio label="large">中等</el-radio>
                        </el-radio-group>
                    </div>
                </el-popover>
                <el-popover placement="bottom" :width="120" trigger="click">
                    <template #reference>
                        <el-button link>
                            <el-icon :size="20"><Setting /></el-icon>
                        </el-button>
                    </template>
                    <div>
                        <el-checkbox v-model="checkColAll" :indeterminate="isIndeterminate" @change="onCheckColAll">全选/不选</el-checkbox>
                        <el-scrollbar height="400px">
                            <el-checkbox-group v-model="columns" @change="onCheckedCol" >
                                <el-checkbox v-for="col in column" :key="col" :label="col.prop">{{col.label}}</el-checkbox>
                            </el-checkbox-group>
                        </el-scrollbar>
                    </div>
                </el-popover>
            </div>
            <el-table :data="data" border stripe :size="size" :height="tableHeight" :max-height="maxHeight" row-key="id" :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
                v-loading="loading" :header-cell-style="headerCellStyle" :cell-style="cellStyle" 
                @selection-change="onSelectionChange" style="width: 100%;">
                <template v-for="item in column" :key="item">
                    <el-table-column v-if="!item.prop && !item.label && !item.isShow" :fixed="item.fixed" type="selection" width="45"></el-table-column>
                    <!-- color值 -->
                    <el-table-column v-else-if="item.type == 'color' && !item.isShow" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <span :style="{color: scope.row[item.prop]}">{{scope.row[item.prop]}}</span>
                        </template>
                    </el-table-column>
                    <!-- icon图标 -->
                    <el-table-column v-else-if="item.type == 'icon' && !item.isShow" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-icon :size="20">
                                <component :is="scope.row[item.prop]"></component>
                            </el-icon>
                        </template>
                    </el-table-column>
                    <!-- el-statistic -->
                    <el-table-column v-else-if="item.type == 'statistic' && !item.isShow" 
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
                    <el-table-column v-else-if="item.type == 'image' && !item.isShow" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-image :src="scope.row[item.prop]" :preview-src-list="[scope.row[item.prop]]" :z-index="9999" fit="cover" style="width: 50px; height: 50px"/>
                        </template>
                    </el-table-column>
                    <!-- el-rate -->
                    <el-table-column v-else-if="item.type == 'rate' && !item.isShow" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-rate v-model="scope.row[item.prop]" disabled allow-half />
                        </template>
                    </el-table-column>
                    <!-- el-tag -->
                    <el-table-column v-else-if="item.type == 'tag' && !item.isShow" show-overflow-tooltip
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
                    <el-table-column v-else-if="item.type == 'button' && !item.isShow" show-overflow-tooltip
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-button @click="$emit('onButtonClick',scope.row)" :type="item.option.type" link :size="item.option.size">
                                {{scope.row[item.alias==null?item.prop:item.alias]}}    
                            </el-button>
                        </template>
                    </el-table-column>
                    <!-- el-switch -->
                    <el-table-column v-else-if="item.type == 'switch' && !item.isShow" show-overflow-tooltip 
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
                    <el-table-column v-else-if="item.type == 'progress' && !item.isShow" show-overflow-tooltip 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <el-progress :percentage="scope.row[item.alias==null?item.prop:item.alias]" 
                            :status="item.option.status"
                            :color="item.option.color"/>
                        </template>
                    </el-table-column>
                    <!-- 字典值  -->
                    <el-table-column v-else-if="item.type == 'dict' && !item.isShow" 
                        :label="item.label" :align="item.align != null ? item.align : 'center'" :width="item.width">
                        <template #default="scope">
                            <span>{{common.getDictLabel(item.dictType, scope.row[item.prop])}}</span>
                        </template>
                    </el-table-column>
                    <!-- 其他数据列 -->
                    <el-table-column v-else-if="!item.isShow" show-overflow-tooltip 
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