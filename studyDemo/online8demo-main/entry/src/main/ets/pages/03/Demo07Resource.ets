@Entry
@Component
struct Demo07Resource {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Row() {
        Text($r('app.string.title'))
          .fontSize($r('app.float.titleSize'))
          .fontColor(Color.White)
      }
      .width(200)
      .height(200)
      .backgroundColor($r('app.color.mainColor'))
      Row() {
        Text($r('app.string.title'))
          .fontSize(30)
          .fontColor(Color.White)
      }
      .width(200)
      .height(200)
      .backgroundColor($r('app.color.footColor'))
    }
  }
}