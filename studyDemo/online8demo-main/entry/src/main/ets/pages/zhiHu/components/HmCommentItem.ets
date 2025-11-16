import { ReplyItem, ReplyItemModel } from "../models"

@Preview
@ComponentV2
struct HmCommentItem {
  @Param item: ReplyItemModel = new ReplyItemModel({} as ReplyItem) // 仅仅只是给个默认值
  @Event changeLike: () => void = () => {}
  build() {
    Row({ space: 10 }) {
      Image(this.item.avatar)
        .width(40)
        .height(40)
        .borderRadius(20)

      Column({ space: 10 }) {
        Text(this.item.author)
          .fontColor("#303a43")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Text(this.item.content)
          .fontColor("#2f3642")
          .lineHeight(22)
        Row() {
          Text(`${this.item.time} .IP属地${this.item.area}`)
            .fontColor("#cacaca")
            .fontSize(12)

          Row({ space: 4 }) {
            Image($r("app.media.ic_like"))
              .width(12)
              .height(12)
              .fillColor(this.item.likeFlag ? Color.Red : "#cacaca")

            Text(this.item.likeNum.toString())
              .fontColor(this.item.likeFlag ? Color.Red : "#cacaca")
              .fontSize(12)
          }
          .onClick(() => {
            // 调用到了老爹方法
            this.changeLike() // this是自己组件

            // // 根据是否喜欢, 进行一个判断, 如果未喜欢, 才+1
            // if (this.item.likeFlag) {
            //   // 点过赞
            //   this.item.likeNum--
            // }
            // else {
            //   // 没有点过赞
            //   this.item.likeNum++
            // }
            // this.item.likeFlag = !this.item.likeFlag
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

    }
    .alignItems(VerticalAlign.Top)
    .padding(20)
    .width('100%')
  }
}
export { HmCommentItem }