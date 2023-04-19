import request from '@/utils/request'
import Layout from '@/components/layout/Index.vue'

const modules = import.meta.glob('../views/**/**.vue')
const layoutModules = import.meta.glob("../components/layout/**.vue")

// 根据菜单构建动态路由
export const filterRouter = (routers:any, level:any) => {
    level = level || 0
    const accessedRouters = routers.filter( (router:any) => {
        if (router.isShow) {
            var setIframe = () => {
                router.component = loadView(`/common/Iframe`)
                router.props = { url: router.path }
                router.path = "/" + router.name
            }

            if(router.path && router.path.startsWith('http') && router.meta.openMode === 1){
                setIframe()
            } else if(router.path && router.path.startsWith('/') && router.path.indexOf('.htm') != -1){
                if(router.meta.openMode === 1){
                    setIframe()
                } else {
                    router.path = location.href.substring(0, location.href.indexOf('/', location.href.indexOf('/', location.href.indexOf('/') + 1) + 1)) + router.path
                }
            } else if(router.component){
                const component = router.component
                if(component === 'Layout'){
                    router.component = level > 0 ? loadView(router.path) : Layout
                } else {
                    router.component = loadView(component) || layoutModules[`../components/layout/Empty.vue`]
                }
            }

            if (router.children && router.children.length) {
                router.children = filterRouter(router.children, level + 1)
            }
            return true
        }
        return false
    })
    return accessedRouters
}

export const loadView = (view:any) => {
    view = view.substring(0, 1) === '/' ? view : '/' + view
    return modules[`../views${view}.vue`]
}

// 获取当前用户的权限菜单
export function generateRoutes(){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysmenu/menus',
            method: 'get'
        }).then( (res:any) => {
            const routers = filterRouter(res.data.result, 0)
            resolve(routers)
        })
    })
}