import request from '@/utils/request'

export function classifyList(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/classify/list',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function classifySave(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/classify/save',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function classifyUpdate(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/classify/update',
            method: 'post',
            data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function classifyDel(id:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/lowcode/lcPages/classify/delete/' + id,
            method: 'get',
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}