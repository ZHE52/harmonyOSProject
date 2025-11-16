@Entry
@Component
struct Demo04 {
  @State sliderWidth: number = 400
  @State sliderHeight: number = 400

  // 底部滑块，可以通过拖拽滑块改变容器尺寸
  @Builder
  slider() {

    Slider({
      value: this.sliderHeight,
      min: 100,
      max: 400,
      style: SliderStyle.OutSet
    })
      .blockColor(Color.White)
      .width('60%')
      .height(50)
      .position({ x: '20%', y: '80%' })
      .onChange((value)=>{
        this.sliderHeight = value
      })

    Slider({
      value: this.sliderWidth,
      min: 100,
      max: 400,
      style: SliderStyle.OutSet
    })
      .blockColor(Color.White)
      .width('60%')
      .height(50)
      .position({ x: '20%', y: '87%' })
      .onChange((value)=>{
        this.sliderWidth = value
      })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Text('宽度:' + this.sliderWidth.toFixed(0) + ' 高度:' + this.sliderHeight.toFixed(0))
        .zIndex(2)
        .translate({ x: 20, y: 20 })
        .fontColor(Color.Orange)
      Column() {
        // 动态修改该容器的宽高
        Column() {
          Column() {
            Image($r("app.media.avatar"))
              .width('100%')
              .height('100%')
          }
          .border({ width: 2, color: Color.Red }) // 边框，仅用于展示效果
          .aspectRatio(1)
          // 布局能力 4：缩放能力
          // 子组件的宽高按照预设的比例，随容器组件发生变化，且变化过程中子组件的【宽高比】不变。

          // 实现方式：
          // 给子组件设置 aspectRatio即可 设置的值是 宽度/高度

        }
        .backgroundColor(Color.Gray)
        .height(this.sliderHeight)
        .width(this.sliderWidth)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        this.slider()
      }
      .width('100%')
      .height('100%')
      .backgroundColor("#F1F3F5")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }

  }
}