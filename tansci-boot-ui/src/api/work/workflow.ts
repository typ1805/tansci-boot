import request from '@/utils/request'

// 模型列表
export function modelList(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/modelList',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 流程定义
export function processDefinitionList(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/processDefinitionList',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 激活流程
export function activateProcess(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/activateProcess',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 挂起流程
export function suspendProcess(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/suspendProcess',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 删除流程
export function deleteDeployment(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/deleteDeployment',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 删除正在运行的流程
export function deleteProcessInstance(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/deleteProcessInstance',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 任务列表
export function taskList(params:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/taskList',
            method: 'get',
            params: params
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 部署流程
export function deployProcess(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/deployProcess',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}

// 启动流程
export function startProcessInstance(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/startProcessInstance',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}


// 任务审批通过
export function approveTask(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/approveTask',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}


// 任务被拒绝
export function rejectTask(data:any){
    return new Promise((resolve, reject) => {
        request({
            url: '/tansci/system/work/workflow/rejectTask',
            method: 'post',
            data: data
        }).then((res:any) => {
            resolve(res.data)
        }).catch((e:any) => {
            reject(e)
        })
    })
}