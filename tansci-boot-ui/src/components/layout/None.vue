<template>
    <router-view v-slot="{ Component }">
        <keep-alive :include="$global.visitedViews.filter(it => it.meta.keepAlive).map(it => it.path.substr(it.path.lastIndexOf('/') + 1))">
            <component :is="Component" :key="$route.path" />
        </keep-alive>
    </router-view>
</template>