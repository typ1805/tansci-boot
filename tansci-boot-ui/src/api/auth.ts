import request from '@/utils/request'
import global from '@/utils/global'

const tokenKey:string = 'tansci_boot_token'
const menuKey:string = 'tansci_boot_menu'

// token信息
export function getToken() {
    return sessionStorage.getItem(tokenKey);
}
export function setToken(token:string) {
    sessionStorage.setItem(tokenKey, token);
}
export function removeToken() {
    sessionStorage.removeItem(tokenKey);
    global.user = {
        authorities: [],
        info: {},
    }
}

// 菜单信息
export function getMenus() {
    let menu = sessionStorage.getItem(menuKey);
    return menu ? JSON.parse(menu) : null;
}

// 菜单信息
export function setMenus(menus:any) {
    return sessionStorage.setItem(menuKey, JSON.stringify(menus));
}

// 登录
export function login(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/auth/login',
            method: 'post',
            data: {
                username: data.username,
                password: data.password,
                code: data.code
            }
        }).then((res:any) => {
            setToken(res.data.result)
            resolve(res.data.result)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 登出
export function logout(){
    request({
        url: '/tansci/system/auth/logout',
        method: 'get'
    }).then(() => {
        removeToken()
        location.reload()
    }).catch((e:any) => {
        removeToken()
        location.reload()
    })
}

// 验证码
export function getCode(){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/auth/code',
            method: 'get'
        }).then((res:any) => {
            resolve(res)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export async function getUserInfo() {
    await request({
        url: '/tansci/system/user/info',
        method: 'get'
    }).then((res:any) => {
        if(res.data.result){
            // 用户信息
            let user = res.data.result
            global.user.info = user
            // 权限信息
            global.user.authorities = user.authorities
        }
    })
}