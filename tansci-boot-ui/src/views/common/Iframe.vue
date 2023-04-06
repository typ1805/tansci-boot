<script setup>
    const props = defineProps({
        url: {
            type: String,
            default: ''
        }
    })
</script>

<template>
    <iframe :src="url" width="100%" height="100%" frameborder="0"></iframe>
</template>

<style scoped>
    iframe{
        position: absolute;
        left: 180px;
        top: 100px;
        right: 0;
        bottom: 0;
    }
</style>

