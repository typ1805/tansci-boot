// 权限
const hasPermission = {
    install(app:any) {
      app.directive('permission', {
        mounted(el:any, binding:any) {
          if (binding.value) {
            const permissionList = app.config.globalProperties.$global.user.authorities
            if (permissionList && permissionList.length && !permissionList.includes(binding.value)) {
              el.remove()
            }
          }
        }
      })
    }
  }
  
  export default hasPermission