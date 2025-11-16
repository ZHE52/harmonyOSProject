import { SelectImageIcon } from './builders/SelectImageIcon'
import { SelectImage } from './components/SelectImage'

// 所谓的图片预览, 就是准备一个更大的空间, 展示图像而已
// [
//   { smallImg: xxx, bigImg: xxx, ... }
// ]

@Entry
@ComponentV2
struct ImageSelectCase {
  @Local showDialog: boolean = false
  @Local imageList: ResourceStr[] = [
    "assets/1.webp",
    "assets/2.webp",
    "assets/3.webp",
    "assets/4.webp",
    "assets/5.webp",
    "assets/6.webp",
    "assets/7.webp",
    "assets/8.webp",
    "assets/9.webp",
    "assets/10.webp"
  ]

  // 最终确定的, 选中后的数组 => 将来是需要提交的 => 放在老爹这里
  @Local selectedList: ResourceStr[] = []

  @Builder showSheet () {
    // 大坑: 外层必须套一个容器组件
    Column() {
      SelectImage({
        imageList: this.imageList,
        selectedList: this.selectedList!!,
        showDialog: this.showDialog!!
        // $selectedList: (list: ResourceStr[]) => {
        //   this.selectedList = list
        // }
      })
    }
  }
  build() {
    Grid() {
      ForEach(this.selectedList, (item: ResourceStr) => {
        GridItem() {
          Image(item)
            .aspectRatio(1) // 保证宽高比
        }
      })

      GridItem() {
        SelectImageIcon()
      }
      .aspectRatio(1)
      .onClick(() => {
        this.showDialog = true
      })
    }
    .padding(20)
    .width('100%')
    .height('100%')
    .rowsGap(10)
    .columnsGap(10)
    .columnsTemplate('1fr 1fr 1fr')
    // 半模态弹层
    .bindSheet($$this.showDialog, this.showSheet(), {
      height: '80%',
      showClose: false
    })
  }
}
