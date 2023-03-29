import request from '@/utils/request'

const userKey:string = 'tansci_boot_user'
const tokenKey:string = 'tansci_boot_token'

// token信息
export function getToken() {
    return sessionStorage.getItem(tokenKey);
}
export function setToken(token:string) {
    sessionStorage.setItem(tokenKey, token);
}
export function removeToken() {
    sessionStorage.removeItem(tokenKey);
}

// 用户信息
export function getUser() {
    return sessionStorage.getItem(userKey);
}
export function setUser(data:any) {
    return sessionStorage.setItem(userKey, JSON.stringify(data));
}
export function removeUser() {
    return sessionStorage.removeItem(userKey);
}

// 登录
export function login(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/auth/login',
            method: 'post',
            data: {
                username: data.username,
                password: data.password,
                code: data.code
            }
        }).then((res:any) => {
                setToken(res.data.result.token)
                setUser(res.data.result)
                resolve(res.data.result.token)
        }).catch((e:any) => {
                reject(e)
        })
    })
}

// 登出
export function logout(){
    request({
        url: '/tansci/auth/logout',
        method: 'get'
    }).then(() => {
        removeToken()
        removeUser()
        location.reload()
    })
}