<script setup>
    const props = defineProps({
        name: {
            type: String,
            default: ''
        }
    })
</script>

<template>
    <component :is="props.name"></component>
</template>