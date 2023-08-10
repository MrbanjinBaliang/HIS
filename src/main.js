/*import Vue from 'vue'
import { createApp } from 'vue'
import App from './App.vue'
import vueRouter from 'vue-router'

vue.$mount('#app')
//createApp(App).mount('#app')

*/

import {createApp} from 'vue'
import App from './App.vue'
import router from '../router/index.js'
import axios from 'axios'


const app = createApp(App)
app.provide('router', router);
app.use(router)

// 创建全局的 Axios 实例
const axiosInstance = axios.create({
	baseURL:'http://127.0.0.1:8081/'
})
// 使用 provide 将实例注入到应用中
app.provide('$axios', axiosInstance);

app.mount('#app');
