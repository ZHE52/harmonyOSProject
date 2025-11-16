@Entry
@Component
struct Demo12 {
  @State currentBreakPoint: string = 'sm'

  build() {
    Column() {
      // GridRow 默认支持 4 个断点
      //  xs:(0vp<=width<320vp) 智能穿戴，比如手表
      //  sm:(320vp<=width<600vp) 手机
      //  md:(600vp<=width<840vp) 折叠屏
      //  lg:(840vp<=width) 平板
      GridRow({
        // breakpoints: {
        //   value: ['420vp', '700vp', '940vp']
        // }
        gutter: 10, // 子项之间的间距
        // 可以根据断点值, 设置一行的列数
        columns: {
          xs: 2,
          sm: 4,
          md: 6,
          lg: 12
        }
      }) {
        ForEach(Array.from({ length: 12 }), (item: string, index: number) => {
          GridCol({
            // 设置一列占的份数
            // span: 2
            span: {
              xs: 1,
              sm: 1,
              md: 1,
              lg: 1
            },
            // 偏移列数 默认值是: 0
            // offset: 0
            offset: {
              xs: 1,
              sm: 1,
              md: 1,
              lg: 1
            }
          }) {
            Text(index.toString())
          }
          .height(100)
          .border({ width: 1, color: Color.Black })
        })
      }
      .width('90%')
      .height('90%')
      .border({ width: 1, color: Color.Orange })
      .onBreakpointChange((breakPoint)=>{
         this.currentBreakPoint = breakPoint
      })

      Text(`断点值: ${this.currentBreakPoint}`)
        .fontSize(30)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#dcdfe8')
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}