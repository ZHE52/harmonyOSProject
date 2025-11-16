// 1. 导入
import { BreakpointKey, BreakpointSystem, BreakPointType } from '../common/BreakpointSystem'

@Entry
@Component
struct Index {

  // 5. 获取断点值
  @StorageProp(BreakpointKey) currentBreakPoint: string = 'sm'


  // 2. 实例化断点类
  breakpointSystem = new BreakpointSystem()

  // 3. 注册
  aboutToAppear(): void {
    this.breakpointSystem.register()
  }

  // 4. 移除注册
  aboutToDisappear(): void {
    this.breakpointSystem.unregister()
  }

  build() {
    Column(){
      Text(this.currentBreakPoint)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(
      new BreakPointType({
        xs: Color.Red,
        sm: Color.Yellow,
        md: Color.Blue,
        lg: Color.Green
      }).getValue(this.currentBreakPoint)
    )
  }
}
