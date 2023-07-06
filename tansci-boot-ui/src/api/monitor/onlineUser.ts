import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/auth/onlineUser',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function kick(token:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/auth/kick/' + token,
            method: 'get'
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
