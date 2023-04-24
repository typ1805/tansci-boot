import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import './styles/index.scss'
import * as ElIcons from '@element-plus/icons-vue'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import 'uno.css'
import globalProperties from './utils/globalProperties'
import hasPermission from './utils/hasPermission'

const app = createApp(App)
app.use(globalProperties)
app.use(router)
app.use(ElementPlus,{
    locale: zhCn,
    size: 'default', 
})
for (const icon in ElIcons) {
    app.component(icon, (ElIcons as any)[icon])
}
app.use(hasPermission)
app.mount('#app');
