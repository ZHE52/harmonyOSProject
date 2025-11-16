// 增强的是: 对[类对象]中属性的观测能力
// 1. 观测这个数据结构, 类前面加上@ObservedV2
@ObservedV2
class User {
  // 2. 在你需要侦听的类的属性前面, 加上@Trace
  @Trace name: string
  @Trace age: number
  // 构造函数
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }
}

@Entry
@ComponentV2
struct Demo02ObservedV2 {
  @Local user: User = new User('帅鹏', 20)
  build() {
    Column() {
      Text('用户:' + this.user.name).fontSize(30)
      Text('年纪:' + this.user.age).fontSize(30)
      Button('修改对象测试').onClick(() => {
        // 对于子属性的修改
        // this.user.name = '鹏哥'
        // this.user.age++

        // 整体替换成了一个新对象
        this.user = new User('刘备', 99)
      })
    }
    .width('100%')
  }
}