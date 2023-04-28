<script setup lang="ts">
    import {defineProps} from 'vue'
    import TbSubmenu from "./TbSubmenu.vue"

	const props = defineProps({
		routers: Array,
        height: Number,
        logo: Object,
        shadow: String,
        title: String
	})

</script>
<template>
    <el-card :shadow="shadow" :body-style="{padding: '1rem'}">
        <div class="logo">
            <el-image :src="logo" fit="fit" style="width: 20%; height:00%"></el-image>
            <span class="title">{{title}}</span>
        </div>
        <el-scrollbar :height="height">
            <el-menu router :default-active="$route.path">
                <template v-for="item in routers" :key="item">
                    <el-menu-item v-if="!item.children || item.children.length <= 1" :index="item.path">
                        <el-icon v-if="item.icon" style="vertical-align: middle;">
                            <component :is="item.icon"></component>
                        </el-icon>
                        <span style="vertical-align: middle;">{{item.meta.title}}</span>
                    </el-menu-item>
                    <TbSubmenu v-else :data="item"></TbSubmenu>
                </template>
            </el-menu>
        </el-scrollbar>
    </el-card>
</template>
<style lang="scss" scoped>
    .logo{
        display: flex;
        justify-content: center;
        align-items: center;
        padding-top: 0.4rem;
        cursor: pointer;
        .title{
            padding-left: 0.6rem;
            color: var(-t);
            font-weight: 700;
            font-size: 18px;
        }
    }
    :deep(.el-menu) {
        padding-left: 0;
        border-right: none;
        background: transparent;
        .el-sub-menu__title:hover{
            background: transparent;
            color: var(--theme);
        }
        .el-menu-item:hover{
            background: transparent;
            color: var(--theme);
        }
        .el-menu-item.is-active {
            background: transparent;
        }
    }
</style>