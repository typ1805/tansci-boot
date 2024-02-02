import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/generator/page',
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
            url: '/tansci/lowcode/generator/delete/' + id,
            method: 'delete',
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function save(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/generator/save',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function execute(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/generator/execute',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function tables(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/generator/tables',
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
            url: '/tansci/lowcode/generator/columns',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}