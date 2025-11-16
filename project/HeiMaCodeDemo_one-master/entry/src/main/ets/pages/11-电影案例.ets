import { BreakpointKey, BreakpointSystem, BreakPointType } from '../common/BreakpointSystem'

interface MovieItem {
  title: string
  img: ResourceStr
}

@Entry
@Component
struct Demo09_demo {
  items: MovieItem[] = [
    { title: '电影标题1', img: $r('app.media.ic_video_grid_1') },
    { title: '电影标题2', img: $r('app.media.ic_video_grid_2') },
    { title: '电影标题3', img: $r('app.media.ic_video_grid_3') },
    { title: '电影标题4', img: $r('app.media.ic_video_grid_4') },
    { title: '电影标题5', img: $r('app.media.ic_video_grid_5') },
    { title: '电影标题6', img: $r('app.media.ic_video_grid_6') },
    { title: '电影标题7', img: $r('app.media.ic_video_grid_7') },
    { title: '电影标题8', img: $r('app.media.ic_video_grid_8') },
    { title: '电影标题9', img: $r('app.media.ic_video_grid_9') },
    { title: '电影标题10', img: $r('app.media.ic_video_grid_10') },
  ]

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
    Grid() {
      ForEach(this.items, (item: MovieItem) => {
        GridItem() {
          Column({ space: 10 }) {
            Image(item.img)
              .borderRadius(10)
            Text(item.title)
              .width('100%')
              .fontSize(20)
              .fontWeight(600)

          }
        }
      })
    }
    .columnsTemplate(
      new BreakPointType({
        xs: '1fr',
        sm: '1fr 1fr',
        md: '1fr 1fr 1fr',
        lg: '1fr 1fr 1fr 1fr'
      }).getValue(this.currentBreakPoint)
    )
    .rowsGap(10)
    .columnsGap(10)
    .padding(10)
  }
}