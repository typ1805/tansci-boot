import { createRouter, createWebHistory } from "vue-router"
import { ElMessage } from 'element-plus'
import { getToken, removeToken, removeUser, setMenus } from "@/api/auth"
import { generateRoutes } from "./permission"

import common from './common'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        ...common
    ]
})

const whiteList = ['/login']
let load = false
router.beforeEach(async (to:any, from:any, next) => {
    // 设置头部
    if(to.meta.title){
        document.title = to.meta.title
    } else {
        document.title = "Tansci Boot"
    }

    if(getToken()){
        // if(to.path === '/login'){
        //     next({ path: '/index' })
        // } else {
            if(load){
                next()
            } else {
                load = true
                try {
                    // 获取菜单
                    await generateRoutes().then( (accessRoutes:any) => {
                        accessRoutes.push({path:'/:pathMatch(.*)*', redirect:'/404'})
                        accessRoutes.forEach( (item:any) => {
                            router.addRoute(item)
                        })

                        let routers = common.concat(accessRoutes)
                        setMenus([...routers])
                    })
    
                    next({ ...to, replace: true })
                } catch (error:any) {
                    removeToken()
                    removeUser()
                    ElMessage.error(error.data || 'Has Error')
                    next(`/login`)
                }
            }
        // }
    } else {
        if(whiteList.indexOf(to.path) !== -1){
            next()
        } else {
            next({ path: "/login" })
        }
    }
})

export default router