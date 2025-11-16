import { AppStorageV2, router } from '@kit.ArkUI'
import { User } from '../07/models/user'

@Entry
@ComponentV2
struct FoodPage {
  @Local user: User = AppStorageV2.connect(User, 'HmUser', () => new User({
    name: '游客',
    age: 0
  }))! // ! 非空断言

  build() {
    Column() {
      Text('外卖业务')
        .fontSize(40)
      Text('这是是外卖业务, 可以看到外卖')
      Text('可以购买').onClick(() => {
        router.pushUrl({
          url: 'pages/food/FoodCartPage'
        })
      })

      Text('用户: ' + this.user.name)
      Text('年纪: ' + this.user.age)
      Button('改值').onClick(() => {
        this.user.name = '吕布'
        this.user.age--
      })
    }
  }
}