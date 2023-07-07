import { createRouter, createWebHistory } from "vue-router"
import { ElMessage } from 'element-plus'
import { getToken, removeToken, setMenus, getUserInfo } from "@/api/auth"
import common from '@/utils/common'
import { generateRoutes } from "./permission"

import staticRouter from './staticRouter'
const router = createRouter({
    history: createWebHistory(),
    routes: [
        ...staticRouter
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
        if(to.path === '/login'){
            next({ path: '/index' })
        } else {
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

                        let routers = staticRouter.concat(accessRoutes)
                        setMenus([...routers])
                    })
                    await common.getDictData()
                    await getUserInfo()

                    next({ ...to, replace: true })
                } catch (error:any) {
                    removeToken()
                    ElMessage.error(error.data || 'Has Error')
                    next(`/login`)
                }
            }
        }
    } else {
        if(whiteList.indexOf(to.path) !== -1){
            next()
        } else {
            next({ path: "/login" })
        }
    }
})

export default router