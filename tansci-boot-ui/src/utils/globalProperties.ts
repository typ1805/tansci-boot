// 全局变量

import global from './global'

const install = (app) => {
  app.config.globalProperties.$global = global
}
export default install
