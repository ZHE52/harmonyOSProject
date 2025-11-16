import { common, Want } from '@kit.AbilityKit';
import { AppStorageV2 } from '@kit.ArkUI';
import { User } from '../07/models/user';

@Entry
@ComponentV2
struct MainPage {
  // 1. 获取上下文对象(后续直接使用)
  // context = getContext(this) as common.UIAbilityContext
  @Local user: User = AppStorageV2.connect(User, 'HmUser', () => new User({
    name: '游客',
    age: 0
  }))! // ! 非空断言

  build() {
    Column() {
      Text('支付宝主业务')
        .fontSize(40)
      Text('用户: ' + this.user.name)
      Text('年纪: ' + this.user.age)
      Button('改值').onClick(() => {
        this.user.name = '吕布'
        this.user.age--
      })

      // 需求: 同/跨模块中Ability跳转
      Button('去买外卖').onClick(() => {
        //2. 准备 want类型的对象并设置属性
        let wantInfo: Want = {
          deviceId: '', // deviceId为空表示本设备
          bundleName: 'com.example.online08project', // AppScope/app.json5确认
          moduleName: 'entry', // moduleName非必选
          abilityName: 'FoodAbility', //  src/main/module.json5确认
          parameters: {
            // 自定义信息
            info: 'xxx'
          },
        }
        //3. 通过上下文对象拉起对应的 Ability
        ;(getContext(this) as common.UIAbilityContext).startAbility(wantInfo)
      })
    }
  }
}