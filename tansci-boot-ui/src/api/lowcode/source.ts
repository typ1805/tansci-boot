import request from '@/utils/request'

export function tables(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/source/tables',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function columns(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/source/columns',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function primary(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/source/primary',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}