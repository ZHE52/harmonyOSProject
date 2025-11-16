import { http } from '@kit.NetworkKit'

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

  async getJokes() {
    // 创建 http 实例
    let intance = http.createHttp()
    // 基于实例, 发送请求
    const res = await intance.request(`https://api-vue-base.itheima.net/api/joke/list?num=${this.jokeNum}`)
    // 整个的后台返回的结果, 利用parse还原成对象格式 { msg: xxx, code: xxx, data: xxx }
    const jokeRes = JSON.parse(res.result.toString()) as JokeResponse
    this.jokes = jokeRes.data
  }

  aboutToAppear(): void {
    this.getJokes()
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