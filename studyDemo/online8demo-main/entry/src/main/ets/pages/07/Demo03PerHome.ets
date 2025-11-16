import { User } from './models/user'
import { PersistenceV2 } from '@kit.ArkUI'


@Entry
@ComponentV2
struct Demo03Home {
  // 尝试从HmUser键取数据, 如果取到了, 就用你的, 没取到就用默认的
  // 参数1: 存储的数据类型
  // 参数2: 存储的键名
  // 参数3: 默认值的回调(构造器)
  @Local user: User = PersistenceV2.connect(User, 'HmUser', () => new User({
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