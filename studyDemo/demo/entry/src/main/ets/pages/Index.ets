// 主要相关类和接口
@Entry
@Component
struct Index {

  build() {
    Column() {
      Text('Hello World')
        .fontSize(30)
      Button('点击打开人脸识别')
        .onClick(()=>{

        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}