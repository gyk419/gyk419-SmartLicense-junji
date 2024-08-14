import { createApp } from 'vue'
import App from './App.vue'
import routers from './routers/router.js'  // router import
import cookies from 'vue3-cookies'

// 위 createApp 코드 아래처럼 변경
const app = createApp(App)
app.use(routers)  // router 추가
app.use(cookies, {
    expire : "1d",
    path : "/",
})
app.mount('#app')


// app.config.globalProperties.cloudtypeUrl = "https://port-0-smartlicense-back-1272llwyzbyro.sel5.cloudtype.app";
