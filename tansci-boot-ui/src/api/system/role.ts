import request from '@/utils/request'

// 分页
export function page(param:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/page',
            method: 'get',
            data: param
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 列表
export function list(param:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/list',
            method: 'get',
            data: param
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
            url: '/tansci/sysrole/save',
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
            url: '/tansci/sysrole/delete/' + id,
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
            url: '/tansci/sysrole/update',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 数据权限
export function dataPermissions(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/dataPermissions',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function orgList(roleId:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/orgList/' + roleId,
            method: 'get'
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 菜单权限
export function menuPermissions(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/menuPermissions',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

export function menuList(roleId:String){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/sysrole/menuList/' + roleId,
            method: 'get'
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}
