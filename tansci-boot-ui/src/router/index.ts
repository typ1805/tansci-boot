import { createRouter, createWebHistory } from "vue-router"

import routers from './routers'

import common from './common'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        ...common,
        ...routers
    ]
})

export default router