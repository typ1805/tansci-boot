import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/lcPages/page',
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
            url: '/system/lcPages/getPagesInfo/' + menuId,
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
            url: '/system/lcPages/save',
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
            url: '/system/lcPages/update',
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
            url: '/system/lcPages/bindMenu',
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
            url: '/system/lcPages/delete/' + id,
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
            url: '/system/lcPages/batchDelete',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}