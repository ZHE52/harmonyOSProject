import { rcp } from '@kit.RemoteCommunicationKit'
import { GlobalVariable, PAGE_PATH } from '../constants'
import { HDMUser, ResponseData } from '../viewmodels'
import { promptAction } from '@kit.ArkUI'
import { auth } from '.'
import { HMRouterMgr } from '@hadss/hmrouter'


class RcpRequestInterceptor implements rcp.Interceptor {
  // context: 请求上下文
  // next: 放行函数(必须要执行, 不执行则不会到下一个执行链)
  intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    // 请求拦截器

    //  注入token
    const user = auth.getUser()
    if (user.token) {
      context.request.headers!.authorization = `Bearer ${user.token}`
    }

    if(typeof context.request.content === 'object'){
      context.request.content = JSON.parse(JSON.stringify(context.request.content).replace(/__ob_/g, '')) as rcp.RequestContent
    }

     return next.handle(context) // 放行到下一个执行链
  }
}

class RcpResponseInterceptor implements rcp.Interceptor {
  // context上下文 -请求上下文
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    const res = await next.handle(context) // 将结构返回下一个执行链

    // TODO 处理401异常问题
    if(res.statusCode === 401) {
      auth.setUser({} as HDMUser)
      HMRouterMgr.push({
        pageUrl: PAGE_PATH.LOGIN_PAGE
      })
    }
    return res
  }
}

// 1. 创建一个会话实例
const instance = rcp.createSession({
  baseAddress: GlobalVariable.BASE_URL, // 基础地址
  interceptors: [ // 配置多个拦截器, 不区分请求和响应
    // 2. 配置请求和响应拦截器
    new RcpRequestInterceptor(),
    new RcpResponseInterceptor()
  ],
  requestConfiguration: {
    transfer: {
      timeout: {
        connectMs: GlobalVariable.TIME_OUT, // 连接超时
        transferMs: GlobalVariable.TIME_OUT, // 传输超时
        inactivityMs: GlobalVariable.TIME_OUT, // 会话超时
      }
    }
  }
})


// 3. 创建一个给外部调用各类方法的类
export class RequestRcp {
  // {id: 112, name: '张三'} ---> url?id=112&name=张三
  static get<T>(url: string, params?: object): Promise<T> {
    return RequestRcp.toRightData<T>(instance.get(url + '?' + RequestRcp.transJSONToParams(params)))
  }

  static post<T>(url: string, data?: object): Promise<T> {
    return RequestRcp.toRightData<T>(instance.post(url, data))
  }

  // delete 支持传body参数 删除购物车需要传递body参数
  static delete<T>(url: string, params?: object, data?: object): Promise<T> {
    const req = new rcp.Request(url + "?" + RequestRcp.transJSONToParams(params), "DELETE", {}, data)
    // instance.delete()
    return RequestRcp.toRightData<T>(instance.fetch(req))
    // return RequestRcp.toRightData<T>(instance.delete(url + "?" + RequestRcp.transJSONToParams(params)))
  }

  static put<T>(url: string, data?: object): Promise<T> {
    return RequestRcp.toRightData<T>(instance.put(url, data))
  }

  static patch<T>(url: string, data?: object): Promise<T> {
    const req = new rcp.Request(url, "PATCH", {}, data)
    return RequestRcp.toRightData<T>(instance.fetch(req))
  }

  static upload<T>() {
  }

  static download<T>() {

  }

  // 将数据转化成正确的数据类型
  static async toRightData<T>(res: Promise<rcp.Response>) {
    const obj = await res
    const result = obj.toJSON() as ResponseData<T>
    if (result.code === GlobalVariable.SUCCESS_CODE) {
      return result.result
    }
    promptAction.showToast({ message: result.msg })
    return Promise.reject(new Error(result.msg))
  }

  // 转化json=> url地址参数的方法 { id: 1, name: 2 } => id=1&name=2
  static transJSONToParams(params?: object) {
    if (params) {
      return Object.keys(params).filter(key => !!params[key]).map(key => `${key}=${params[key]}`).join("&")
    }
    return ""
    // ["id","name"] => ["id=1", "name=2"]
  }
}