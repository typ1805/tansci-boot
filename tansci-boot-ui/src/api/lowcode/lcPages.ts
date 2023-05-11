import request from '@/utils/request'

export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lcPages/page',
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
            url: '/tansci/lcPages/getPagesInfo/' + menuId,
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
            url: '/tansci/lcPages/save',
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
            url: '/tansci/lcPages/update',
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
            url: '/tansci/lcPages/bindMenu',
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
            url: '/tansci/lcPages/delete/' + id,
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
            url: '/tansci/lcPages/batchDelete',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}