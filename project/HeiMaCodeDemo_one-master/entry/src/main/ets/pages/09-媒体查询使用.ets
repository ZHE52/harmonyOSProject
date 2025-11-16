
// 1. 导入模块
import  { mediaquery} from '@kit.ArkUI'

// 2. 创建监听器
const listenerXS = mediaquery.matchMediaSync('(0vp<=width<320vp)')
const listenerSM = mediaquery.matchMediaSync('(320vp<=width<600vp)')
const listenerMD = mediaquery.matchMediaSync('(600vp<=width<840vp)')
const listenerLG = mediaquery.matchMediaSync('(840vp<=width)')
const listenerDark = mediaquery.matchMediaSync('(dark-mode: true)')


@Entry
@Component
struct Index {
  @State currentBreakPoint: string = ''
  @State bgColor: Color = Color.White
  @State message: string = '亮色模式'

  // 3. 注册监听器
  aboutToAppear() {
     listenerXS.on('change', (res: mediaquery.MediaQueryResult)=>{
       if(res.matches){
         this.currentBreakPoint = 'xs'
         this.bgColor = Color.Red
       }
     })

    listenerSM.on('change', (res: mediaquery.MediaQueryResult)=>{
      if(res.matches){
        this.currentBreakPoint = 'sm'
        this.bgColor = Color.Green
      }
    })

    listenerMD.on('change', (res: mediaquery.MediaQueryResult)=>{
      if(res.matches){
        this.currentBreakPoint = 'md'
        this.bgColor = Color.Blue
      }
    })

    listenerLG.on('change', (res: mediaquery.MediaQueryResult)=>{
      if(res.matches){
        this.currentBreakPoint = 'lg'
        this.bgColor = Color.Orange
      }
    })

    listenerDark.on('change', (res: mediaquery.MediaQueryResult)=>{
       this.message = res.matches ? '深色模式' : '亮色模式'
    })
  }


  aboutToDisappear() {
    // 4. 移除监听器
    listenerXS.off('change')
    listenerSM.off('change')
    listenerMD.off('change')
    listenerLG.off('change')
  }

  build() {
    Column(){
      Text(this.currentBreakPoint)
      Text(this.message)
        .fontSize(40)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}
