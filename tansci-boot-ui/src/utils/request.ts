import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios'
import { showMessage } from './status'
import { ElMessage } from 'element-plus'
import { logout, getToken } from '@/api/auth'
import router from '../router'

// 根据环境获得不同的代理模式
const baseURL = import.meta.env.VITE_BASE_URL as string;
const axiosInstance: AxiosInstance = axios.create({
    baseURL: baseURL,
    timeout: 30 * 1000, // 超时时间
    headers: {
        'Content-Type': 'application/json'
    },
})

// axios实例拦截请求
axiosInstance.interceptors.request.use((config: AxiosRequestConfig) => {
        // 设置token
        if (getToken()) {
            config.headers.Authorization = `Bearer ${getToken()}`
        }
        return config;
    },
    (error: any) => {
        return Promise.reject(error);
    }
)

// axios实例拦截响应
axiosInstance.interceptors.response.use(
    (response: AxiosResponse) => {
        if (response.status === 200 && response.data.code == 200) {
            return response;
        } else {
            ElMessage.warning(showMessage(response.status));
            if (response.data.code === 402) {
                logout()
            }

            if (response.data.code == 403 || response.data.code == 401){
                sessionStorage.clear();
                router.push({path: 'login'});
            } 
            return response;
        }
    },
    // 请求失败
    (error: any) => {
        const {response} = error;
        if (response) {
            // 请求已发出，但是不在2xx的范围
            ElMessage.warning(showMessage(response.status));
            return Promise.reject(response.data);
        } else {
            ElMessage.warning('网络连接异常,请稍后再试!');
        }
    }
)

export default axiosInstance