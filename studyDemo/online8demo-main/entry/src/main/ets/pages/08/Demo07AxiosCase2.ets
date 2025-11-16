import axios, { AxiosResponse } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'

interface JokeResponse {
  msg: string
  code: number
  data: string[]
}

@Entry
@ComponentV2
struct Day05_Jokes {
  @Local jokes: string [] = ['笑话 1']
  jokeNum: number = 10

  async getResult () {
    // get  <T = any, R = AxiosResponse<T>, D = any>  (地址, 配置项)
    // 参数1: 接口返回的数据格式类型
    // 参数2: axios的处理后的类型 => AxiosResponse<你的返回数据类型, null>
    // 参数3: 请求参数类型
    const res = await axios.get<JokeResponse, AxiosResponse<JokeResponse, null>, null>('https://api-vue-base.itheima.net/api/joke/list?num=5')
    this.jokes = res.data.data
  }
  aboutToAppear(): void {
    this.getResult()
  }

  build() {
    Column() {
      // 顶部
      this.HeaderBuilder()

      // 笑话列表
      List({ space: 10 }) {
        ForEach(this.jokes, (joke: string) => {
          ListItem() {
            Column({ space: 10 }) {
              Text(joke.slice(0, 10))
                .fontSize(20)
                .fontWeight(600)
              Row({ space: 15 }) {
                titleIcon({ icon: $r('app.media.ic_public_time'), info: '2024-1-1' })
                titleIcon({ icon: $r('app.media.ic_public_read'), info: '阅读(6666)' })
                titleIcon({ icon: $r('app.media.ic_public_comments'), info: '评论(123)' })
              }

              Text(joke)
                .fontSize(15)
                .fontColor(Color.Gray)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(20)

          }
          .borderRadius(10)
          .backgroundColor(Color.White)
          .shadow({ radius: 2, color: Color.Gray })
        })

      }
      .padding(10)
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f6f6f6')
  }

  @Builder
  HeaderBuilder() {
    Row() {
      Image($r('app.media.ic_public_drawer_filled'))
        .width(25);

      Image($r('app.media.ic_public_joke_logo'))
        .width(30)

      Image($r('app.media.ic_public_search'))
        .width(30);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .height(60)
    .padding(10)
    .border({ width: { bottom: 2 }, color: '#f0f0f0' })
    .backgroundColor(Color.White)
  }
}

@Component
struct titleIcon {
  icon: ResourceStr = ''
  info: string = ''

  build() {
    Row() {
      Image(this.icon)
        .width(15)
        .fillColor(Color.Gray)
      Text(this.info)
        .fontSize(14)
        .fontColor(Color.Gray)
    }
  }
}