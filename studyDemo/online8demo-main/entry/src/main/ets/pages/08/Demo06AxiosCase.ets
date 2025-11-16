import axios, { AxiosResponse } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'

interface JokeAxiosRes {
  msg: string
  code: number
  data: string[]
}

@Entry
@ComponentV2
struct Demo06AxiosCase {
  async getResult () {
    // get  <T = any, R = AxiosResponse<T>, D = any>  (地址, 配置项)
    // 参数1: 接口返回的数据格式类型
    // 参数2: axios的处理后的类型 => AxiosResponse<你的返回数据类型, null>
    // 参数3: 请求参数类型
    const res = await axios.get<JokeAxiosRes, AxiosResponse<JokeAxiosRes, null>, null>('https://api-vue-base.itheima.net/api/joke/list?num=5')
    promptAction.showDialog({
      message: JSON.stringify(res.data)
    })
  }
  aboutToAppear(): void {
    this.getResult()
  }
  build() {

  }
}