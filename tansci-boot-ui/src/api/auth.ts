import request from '@/utils/request'

// token key
const tokenKey:string = 'tansci_boot_token'

// 获取token
export function getToken() {
    return sessionStorage.getItem(tokenKey);
}

// 存储token
export function setToken(token:string) {
    sessionStorage.setItem(tokenKey, token);
}

// 删除token
export function removeToken() {
    sessionStorage.removeItem(tokenKey);
}

// 登录
export function login(data:any){
    return new Promise((resolve, reject) => {
      request({
        url: '/system/security/login',
        method: 'post',
        data: {
            username: data.username,
            password: data.password,
            code: data.code,
            uuid: data.uuid
        }
      }).then((res:any) => {
            var token = res.data
            setToken(token)
            resolve(token)
      }).catch((e:any) => {
            reject(e)
      })
    })
}

// 登出
export function logout(){
    request({
        url: '/system/security/logout',
        method: 'get'
    }).then(() => {
        removeToken()
        location.reload()
    })
}