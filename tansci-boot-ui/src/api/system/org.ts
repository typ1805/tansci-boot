import request from '@/utils/request'

// 列表
export function list(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/org/list',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 添加
export function save(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/org/save',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 删除
export function del(id:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/org/delete/' + id,
            method: 'get'
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 修改
export function update(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/system/org/update',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
