@Builder
export function globalItemBuilder (option: string = '默认值') {
  Row() {
    Text(option)
      .fontColor(Color.White)
  }
  .RowStyles()
}

@Styles
function RowStyles () {
  .height(60)
  .backgroundColor(Color.Gray)
  .width('100%')
  .padding({ left: 20, right: 20 })
  .borderRadius(8)
}


@Entry
@Component
struct Demo01Builder {
  @Builder itemBuilder () {
    Row() {
      Text('A. 选项')
        .fontColor(Color.White)
    }
    .RowStyles()
  }

  build() {
    Column({ space: 20 }) {
      // this.itemBuilder()
      // this.itemBuilder()
      // this.itemBuilder()

      // builder支持传参
      globalItemBuilder('A. 黑龙江')
      globalItemBuilder('B. 上海')
      globalItemBuilder('C. 北京')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(Color.Pink)
  }
}