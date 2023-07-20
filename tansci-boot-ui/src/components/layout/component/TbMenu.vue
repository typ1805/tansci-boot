<script setup lang="ts">
    import {useRouter} from 'vue-router'
    import TbSubmenu from "./TbSubmenu.vue"

	const props = defineProps({
		routers: Array,
        height: Number,
        logo: Object,
        shadow: String,
        title: String,
        isCollapse: Boolean
	})

    const emit = defineEmits(['onCollapse'])
    const router = useRouter()

    function toHome(){
        router.push({path: '/index'});
    }

</script>
<template>
    <el-card :shadow="shadow" :body-style="{padding: '1rem 0.2rem', position: 'relative'}">
        <div @click="toHome" class="logo">
            <el-image :src="logo" fit="fit" :style="{width: isCollapse?'60%':'20%', height: '100%'}"></el-image>
            <span v-show="!isCollapse" class="title">{{title}}</span>
        </div>
        <el-scrollbar :height="height" :min-size="10">
            <el-menu router :default-active="$route.path" :collapse="isCollapse">
                <template v-for="item in routers" :key="item.name">
                    <el-menu-item v-if="!item.children || item.name == item.children[0].name" :index="item.path">
                        <el-icon v-if="item.icon" style="vertical-align: middle;">
                            <component :is="item.icon"></component>
                        </el-icon>
                        <span style="vertical-align: middle;">{{item.meta.title}}</span>
                    </el-menu-item>
                    <TbSubmenu v-else :data="item"></TbSubmenu>
                </template>
            </el-menu>
        </el-scrollbar>
        <el-button @click="$emit('onCollapse', isCollapse)" :icon="isCollapse ? 'CaretRight':'CaretLeft'" circle size="small" class="collapse"></el-button>
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
    .collapse{
        position: absolute;
        right: -7px;
        bottom: -7px;
        transform:rotate(50deg);
    }
</style>