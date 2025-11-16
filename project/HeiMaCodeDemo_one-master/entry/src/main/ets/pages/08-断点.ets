@Entry
@Component
struct Index {
  @StorageProp('currentBreakpoint') curBp: string = 'sm'

  build() {
    Flex({justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center}) {
      Text(this.curBp).fontSize(50).fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
  }
}
