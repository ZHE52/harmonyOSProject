import { http } from '@kit.NetworkKit'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Demo04HttpCase {
  async sendHttp () {
    // 1. 创建http实例
    const intance = http.createHttp()
    // 2. 通过实例, 发起请求连接
    const res = await intance.request('https://zhousg.atomgit.net/harmonyos-next/takeaway.json', {
      method: http.RequestMethod.GET,
    })
    // res.result 是一个 string 类型
    promptAction.showDialog({
      message: res.result as string
    })
  }

  aboutToAppear(): void {
    this.sendHttp()
  }

  build() {

  }
}