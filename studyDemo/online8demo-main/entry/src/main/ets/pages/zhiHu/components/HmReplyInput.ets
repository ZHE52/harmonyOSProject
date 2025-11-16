import { promptAction } from "@kit.ArkUI"

@ComponentV2
struct HmReplyInput {
  @Local content: string = ""
  @Event publishComment: (content: string) => void = (content: string) => {}

  handleSubmit () {
    if (this.content.trim() === '') {
      promptAction.showToast({
        message: '请输入评论文本'
      })
      return
    }
    // 调用事件, 通知到老爹去更新(告诉更新的内容)
    this.publishComment(this.content)
    this.content = ''
  }
  build() {
    Row({ space: 10 }) {
      TextInput({ text: $$this.content, placeholder: '～请留下您的神评论' })
        .layoutWeight(1)
        .height(40)
        .onSubmit(() => {
          this.handleSubmit()
        })
      Button("发布").onClick(() => {
        this.handleSubmit()
      })
      // .enabled(false) // 控制是否禁用
      // .stateStyles({
      //   disabled: {
      //     .backgroundColor(Color.Orange)
      //   }
      // }) // 控制禁用时的样式
    }
    .padding({ left: 10, right: 10 })
    .width('100%')
    .height(60)
  }
}
export { HmReplyInput }