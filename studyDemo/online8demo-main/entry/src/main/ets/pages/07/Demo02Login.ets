import { AppStorageV2, router } from '@kit.ArkUI'
import { User } from './models/user'

@Entry
@ComponentV2
struct Demo02Login {
  @Local username: string = ""
  @Local password: string = ""
  build() {
    Column({ space: 20 }) {
      Image($r('app.media.startIcon'))
        .width(60)
      TextInput({ placeholder: '请输入用户名', text: $$this.username })
      TextInput({ placeholder: '请输入密码', text: $$this.password })
        .type(InputType.Password)
      Button("登录")
        .width('100%')
        .onClick(() => {
          // 判断用户名或者密码是否正确 => 假定都正确
          // 将用户信息, 存储到 AppStorageV2 中

          // 获取 或 创建, 第二次点击登录时, 进行的是获取
          AppStorageV2.connect(User, 'HmUser', () => new User({
            name: this.username,
            age: 18
          }))

          // 跳转路由
          router.pushUrl({
            url: 'pages/07/Demo02User'
          })

          // 如果第二个参数, 没有写键名, 会将类型的name, 当成键名
          // AppStorageV2.connect(User, () => new User({
          //   name: this.username,
          //   age: 18
          // })
        })
    }
    .padding(20)
    .width('100%')
  }
}