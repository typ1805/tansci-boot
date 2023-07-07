import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/page',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function getPagesInfo(menuId:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/pagesInfo/' + menuId,
            method: 'get'
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
            url: '/tansci/lowcode/lcPages/save',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function update(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/update',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function bindMenu(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/bindMenu',
            method: 'post',
            data
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
            url: '/tansci/lowcode/lcPages/delete/' + id,
            method: 'get',
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function batchDelete(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/batchDelete',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}