import request from '@/utils/request'

// 列表
export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/syslog/operLog',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
