import { User } from './models/user'
import { AppStorageV2, router } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Demo02User {
  // @Local user: User = 获取AppStorageV2的值
  @Local user: User = AppStorageV2.connect(User, 'HmUser', () => new User({
    name: '游客',
    age: 0
  }))!
  build() {
    Column() {
      Row({ space: 20 }) {
        Image($r('app.media.dragon'))
          .width(60)
          .aspectRatio(1)
          .borderRadius(30)
        Column({ space: 10 }) {
          Text('姓名：' + this.user.name)
          Text(`年龄：` + this.user.age)

          Button('修改信息').onClick(() => {
            this.user.name = '帅鹏'
            this.user.age++
          })
        }
      }
      .alignItems(VerticalAlign.Center)
      .padding(20)
      .width('100%')

      Button('跳转到首页').onClick(() => {
        router.pushUrl({
          url: 'pages/07/Demo02Home'
        })
      })
      Button('获取所有的键名').onClick(() => {
        console.log(JSON.stringify(AppStorageV2.keys()))
      })
      Button("退出").onClick(() => {
        // 移出AppStorageV2临时存储
        AppStorageV2.remove('HmUser')
        // // 跳转到登录页
        // router.replaceUrl({
        //   url: 'pages/07/Demo02Login'
        // })
      })
    }
    .width('100%')
    .height('100%')
  }
}