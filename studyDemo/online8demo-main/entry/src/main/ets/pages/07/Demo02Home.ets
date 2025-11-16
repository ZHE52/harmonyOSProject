import { User } from './models/user'
import { AppStorageV2 } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Demo02Home {
  // 尝试从HmUser键取数据, 如果取到了, 就用你的, 没取到就用默认的
  @Local user: User = AppStorageV2.connect(User, 'HmUser', () => new User({
    name: '游客',
    age: 0
  }))! // ! 非空断言

  build() {
    Column() {
      Text('我是首页')
        .fontSize(30)
      Text('用户: ' + this.user.name)
      Text('年纪: ' + this.user.age)
      Button('改值').onClick(() => {
        this.user.name = '吕布'
        this.user.age--
      })
    }
  }
}