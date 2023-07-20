<script setup lang="ts">
	import { watch, reactive, toRefs } from "vue"
    import { TabsPaneContext } from "element-plus"
    import { useRoute, useRouter } from "vue-router"
    import { HOME_URL, TABS_BLACK_LIST } from "@/config/config"

    const route = useRoute();
    const router = useRouter();

    const state = reactive({
        tabsMenuValue: HOME_URL,
        tabsMenuList:[
            {title:'首页', path: HOME_URL, icon:'HomeFilled', close: false}
        ]
    })

    const {tabsMenuValue, tabsMenuList} = toRefs(state)

    // 监听路由的变化（防止浏览器后退/前进不变化 tabsMenuValue）
    watch(
        () => route.path,
        () => {
            let params = {
                title: route.meta.title as string,
                path: route.path,
                close: true
            };
            onAddTabManu(params);
        },
        {
            immediate: true
        }
    )

    function onAddTabManu(tabItem: any){
        if (TABS_BLACK_LIST.includes(tabItem.path)) return;

        if (state.tabsMenuList.every(item => item.path !== tabItem.path)) {
            state.tabsMenuList.push(tabItem);
        }
        state.tabsMenuValue = tabItem.path;
        router.push(tabItem.path);
    }

    function onTabMenuClick(tabItem: TabsPaneContext){
        let path = tabItem.props.name as string;
        router.push(path);
    }

    function onTabMenuRemove(tabItem: String){
        let _tabsMenuValue = state.tabsMenuValue;
        let _tabsMenuList = state.tabsMenuList;
        if (_tabsMenuValue === tabItem) {
            _tabsMenuList.forEach((item, index) => {
                if (item.path !== tabItem) return;

                let nextTab = _tabsMenuList[index + 1] || _tabsMenuList[index - 1];
                if (!nextTab) return;

                _tabsMenuValue = nextTab.path;
                router.push(nextTab.path);
            });
        }
        state.tabsMenuValue = _tabsMenuValue;
        state.tabsMenuList = _tabsMenuList.filter(item => item.path !== tabItem);
    }

    function onCloseCurrentTab(){
        if (state.tabsMenuValue === HOME_URL) return;
        onTabMenuRemove(state.tabsMenuValue);
    }

    function onCloseOtherTab(){
        state.tabsMenuList = state.tabsMenuList.filter(item => {
			return item.path === state.tabsMenuValue || item.path === HOME_URL;
		});
    }

    function onCloseAllTab(){
        state.tabsMenuList = state.tabsMenuList.filter(item => {
			return item.path === HOME_URL;
		});
        router.push(HOME_URL);
    }

</script>
<template>
    <div class="tabs-menu">
        <el-tabs type="card" v-model="tabsMenuValue" @tab-click="onTabMenuClick" @tab-remove="onTabMenuRemove">
            <el-tab-pane v-for="item in tabsMenuList"
                :key="item.path"
                :path="item.path"
                :label="item.title"
                :name="item.path"
                :closable="item.close"
                @node-contextmenu="onTabMenuRemove">
                <template #label>
                    <el-icon v-if="item.icon" style="vertical-align: middle;">
                        <component :is="item.icon"></component>
                    </el-icon>
                    <el-dropdown :id="item.path" trigger="contextmenu">
                        <span style="vertical-align: middle">{{ item.title }}</span>
                         <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item icon="CircleCloseFilled" @click="onCloseCurrentTab">关闭当前</el-dropdown-item>
                                <el-dropdown-item icon="CircleClose" @click="onCloseOtherTab">关闭其他</el-dropdown-item>
                                <el-dropdown-item icon="CloseBold" @click="onCloseAllTab">关闭所有</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
                </template>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<style lang="scss">
    .tabs-menu{
        width: 100%; 
        .el-tabs > .el-tabs__header,.el-tabs__item {
			box-sizing: border-box;
			height: 32px;
		}
        .el-tabs--card > .el-tabs__header{
            border: none;
        }
        .el-tabs--card > .el-tabs__header .el-tabs__nav{
            border-bottom: none;
            // background: #ffffff;
        }
    }
</style>