<script setup lang="ts">
	const props = defineProps({
		data: Array
	})
</script>
<template>
    <el-sub-menu :index="data.path">
		<template #title>
			<el-icon v-if="data.icon" style="vertical-align: middle;">
				<component :is="data.icon"></component>
			</el-icon>
			<span style="vertical-align: middle;">{{data.meta.title}}</span>
		</template>
		<template v-for="item in data.children" :key="item.name">
            <el-menu-item v-if="!item.children  || item.children.length <= 1" :index="item.path">
				<el-icon v-if="item.icon" style="vertical-align: middle;">
					<component :is="item.icon"></component>
				</el-icon>
				<span style="vertical-align: middle;">{{item.meta.title}}</span>
			</el-menu-item>
			<TbSubmenu v-else :data='item'></TbSubmenu>
		</template>
	</el-sub-menu>
</template>