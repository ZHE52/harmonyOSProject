@ComponentV2
struct SelectImage {
  @Param imageList:ResourceStr[] = []
  // 组件内部, 一定是要维护一个临时状态 => 临时选中了哪些图片
  @Local selectList: ResourceStr[] = []

  // 父传子, 传递下来, 已选中的数组
  @Param selectedList: ResourceStr[] = []
  @Event $selectedList: (val: ResourceStr[]) => void = (val: ResourceStr[]) => {}

  @Param showDialog: boolean = false
  @Event $showDialog: (val: boolean) => void = (val: boolean) => {}

  @Computed
  get imgLength (): number {
    return this.selectList.length
  }

  // 组件即将要展示出来
  aboutToAppear(): void {
    this.selectList = [...this.selectedList]
  }

  build() {
    Column() {
      Row() {
        Text('取消').onClick(() => {
          this.$showDialog(false)
        })
        Text(`已选中 ${this.imgLength}/10 张`)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('确定').onClick(() => {
          // 这里直接进行传递赋值, 将 临时状态 和 最终选中状态 赋值成了一个数组
          // this.$selectedList(this.selectList)

          // 进行浅拷贝, 拷贝图像即可
          this.$selectedList([...this.selectList])
          this.$showDialog(false)
        })
      }.width('100%').padding(20)
      Grid() {
        ForEach(this.imageList, (item: ResourceStr) => {
          GridItem() {
            Stack({ alignContent: Alignment.BottomEnd }) {
              Image(item)
              // 这里做个判断, item 在 selectList 中包含, 才是被选中
              if (this.selectList.includes(item)) {
                Image($r('sys.media.ohos_ic_public_select_all'))
                  .width(30)
                  .fillColor(Color.Green)
                  .backgroundColor(Color.White)
                  .margin(5)
              }
            }
          }
          .aspectRatio(1) // 保证宽高比是 1 比 1
          .onClick(() => {
            if (this.selectList.includes(item)) {
              // 当前点击的这个已经包含了, 再点击肯定是取消, 就是要将该项删除
              this.selectList = this.selectList.filter(v => v !== item)
            }
            else {
              this.selectList.push(item)
            }
          })
        })
      }
      .padding(20)
      .layoutWeight(1)
      .rowsGap(10)
      .columnsGap(10)
      .columnsTemplate('1fr 1fr 1fr')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f7f8')
  }
}
export { SelectImage }