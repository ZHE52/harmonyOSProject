import { bbb } from "../component/bbb";

@Entry
@Component
struct Index {
  @State message: string = 'xxx';

  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
      aaa()
        .width('100%')
        .height(20)
        .backgroundColor(Color.Red)
      bbb()
        .width('100%')
        .height(20)
        .backgroundColor(Color.Blue)
    }
    .height('100%')
    .width('100%')
  }
}


@Component
struct aaa {
  build() {
    Text('123')
  }
}