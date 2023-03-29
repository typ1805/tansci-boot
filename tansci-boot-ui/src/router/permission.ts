import request from '@/utils/request'
import common from '@/utils/common'

const viewModules = import.meta.glob("../views/**/**.vue")
const layoutModules = import.meta.glob("../components/layout/**.vue")

// 根据菜单构建动态路由
export const filterAsyncRouter = (routers:any, level:any) => {
    level = level || 0
    const accessedRouters = routers.filter( (router:any) => {
        if (router.isShow === 1) {
            var setIframe = () => {
                router.component = loadView(`/common/Iframe`)
                router.props = { url: router.url }
                router.path = "/" + router.url
            }

            if(router.url && router.url.startsWith('http')){
                if(router.openMode == '0'){
                    setIframe()
                }
            } else if(router.url && router.url.startsWith('/') && router.url.indexOf('.htm') != -1) {
                if(router.openMode == '0'){
                    setIframe()
                }else{
                    router.path = location.href.substring(0, location.href.indexOf('/', location.href.indexOf('/', location.href.indexOf('/') + 1) + 1)) + router.path
                }
            } else if (router.componentName) { 
                router.props = { 
                    name: router.componentName, 
                    id :router.id
                }

                // 根据组件类型渲染
                router.component = loadView(`/common/Component`)        
            } else if (router.component) { // 如果是现成组件
                const component:any = router.component
                if (component === 'Layout') {
                    router.path = "/" + common.uuid()
                    router.component = level > 0 ? layoutModules[`../components/layout/None.vue`] : loadLayoutView()
                } else {
                    router.path = router.path.startsWith('/') ? router.path : '/' + router.path
                    router.component = loadView(component) || layoutModules[`../components/layout/Empty.vue`]
                }
            }
            if (router.children && router.children.length) {
                router.children = filterAsyncRouter(router.children, level + 1)
            }
            return true
        }
        return false
    })
    return accessedRouters
}

export const loadLayoutView = () => {
    return layoutModules[`../components/layout/Index.vue`]
}

export const loadView = (view:any) => {
    view = view.substring(0, 1) === '/' ? view : '/' + view
    return viewModules[`../views${view}.vue`]
}

// 获取当前用户的权限菜单
export function generateRoutes(){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysmenu/tree',
            method: 'get'
        }).then( (res:any) => {
            let data = recastData(res.data.result, [])
            console.log(data)
            const asyncRouter = filterAsyncRouter(data, 0) 
            resolve(asyncRouter)
        })
    })
}

export function recastData(data:any, arr:any){
    data.forEach( (item:any) => {
        arr.push({
            path: item.url,
            name: item.url,
            icon: item.icon,
            isShow: item.isShow,
            component: item.component,
            meta: { 
                title: item.chineseName,
                keepAlive: item.keepAlive
            }
        })
        if (item.children && item.children.length) {
            recastData(item.children, arr);
        }
    });
}