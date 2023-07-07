import request from '@/utils/request'

// 分页
export function page(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/user/page',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 列表
export function list(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/user/list',
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
            url: '/tansci/system/user/save',
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
            url: '/tansci/system/user/delete/' + id,
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
            url: '/tansci/system/user/update',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 修改密码
export function modifyPass(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/user/modifyPass',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 角色
export function roleList(){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/role/list',
            method: 'get'
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
