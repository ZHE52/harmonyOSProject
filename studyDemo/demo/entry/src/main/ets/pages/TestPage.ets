
@Entry
@Component
struct TestPage {
  build() {
    Column() {
      Text('测试页面')
        .fontSize(30)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
} 