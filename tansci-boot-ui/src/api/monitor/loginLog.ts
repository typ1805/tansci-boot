import request from '@/utils/request'

// 列表
export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/syslog/loginLog',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
