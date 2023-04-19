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
        left: 0;
        top: 0;
        right: 0;
        bottom: 0;
    }
</style>

