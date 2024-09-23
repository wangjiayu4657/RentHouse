import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import { JSON } from '@kit.ArkTS'

const request = axios.create({
  baseURL: 'http://172.30.89.196:6060',
  // baseURL: 'http://192.168.2.106:6060',
  timeout: 20000
})

//请求拦截器
request.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  //添加 token
  // config.headers.token = token
  return config
}, (err: AxiosError) => {
  //请求错误时可以在此做些处理
  promptAction.showToast({ message: `请求: ${err.message}` })
  return Promise.reject(err)
})

//响应拦截器
request.interceptors.response.use((response: AxiosResponse) => {
  if (response.data.code === 200) {
    return response.data.data
  } else {
    promptAction.showToast(response.data.message)
    return Promise.reject(response.data.message)
  }
}, (err: AxiosError) => {
  promptAction.showToast({ message: `响应: ${err.message}` })
  return Promise.reject(err.message)
})


class HttpUtil {
  get<T>(url: string, params?: Object ) {
    return request.get<null, T>(url, { params })
  }

  post<T>(url: string, data?: Object) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: Object) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: Object) {
    return request.delete<null, T>(url, { params })
  }
}

const httpUtil = new HttpUtil()
export default httpUtil as HttpUtil


