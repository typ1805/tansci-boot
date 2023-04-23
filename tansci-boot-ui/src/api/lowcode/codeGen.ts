import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/code/page',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function del(id:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/code/delete/' + id,
            method: 'delete',
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function execute(param:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/code/execute',
            method: 'post',
            data: param
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}