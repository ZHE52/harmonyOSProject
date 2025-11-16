import {KeyboardAvoidMode, promptAction} from '@kit.ArkUI'
import { accessManager, Logger } from 'basic'
import { audioCapturerManager, coreSpeechManager, CoreSpeechManager } from '.'

export enum VoiceState {
  DEFAULT, // 默认
  VOICING, // 录制中
  VOICEOVER // 录制结束
}

@Preview
@ComponentV2
export struct HDMAudioSearch {
  @Local voiceState: VoiceState = VoiceState.DEFAULT
  @Local keyword: string = ''
  @Event
  onComplete: (keyword: string) => void = () => {
  }

  // 开始录音
  async startRecord() {
    // 1. 检查麦克风的权限
    accessManager.checkPermission(["ohos.permission.MICROPHONE"], async ()=>{
      // promptAction.showToast({message: '可以开始录音了'})
      this.voiceState = VoiceState.VOICING

      // 1.1 先初始化语音识别引擎
      await coreSpeechManager.initEngine((res: string)=>{
         this.keyword = res
      })

      audioCapturerManager.start((bf)=>{
         // 1.2 开始音频分析
         coreSpeechManager.startTransVoice(bf)
      })
    }, ()=>{
      promptAction.showToast({message: '您单签没有开启权限, 无法使用语音功能'})
    })
  }

  // 结束录音
  async closeRecord() {
    this.onComplete(this.keyword.replace(/[^\p{L}\p{N}\s]/gu, ''))
    this.keyword = ''
    this.voiceState = VoiceState.VOICEOVER
    await audioCapturerManager.stop()
    // 结束音频分析
    coreSpeechManager.stopTransVoice()
  }

  aboutToAppear() {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
  }

  build() {
    Column() {
      if (this.voiceState !== VoiceState.DEFAULT) {
        Column({ space: 16 }) {
          if (this.voiceState === VoiceState.VOICING) {
            Text('请说，我在聆听...')
              .fontSize(14)
            Text(this.keyword)
              .fontSize(14)
              .margin({
                top: 20
              })
          } else if (this.voiceState === VoiceState.VOICEOVER && this.keyword === '') {
            Text('未检测到语音，请长按按钮重试')
              .fontSize(14)
          }
          Text() {
            Span('你可以这样说：')
            Span('太阳眼镜/冬款连衣裙')
              .fontColor($r('[basic].color.gray'))
          }
          .fontSize(12)
        }
        .justifyContent(FlexAlign.Center)
        .height(150)
      }
      Blank()
      Button() {
        Row({ space: 4 }) {
          Image($r('sys.media.ohos_ic_public_voice'))
            .width(16)
            .aspectRatio(1)
            .fillColor($r('[basic].color.white'))
          if (this.voiceState === VoiceState.VOICING) {
            Text('松开立即搜索')
              .fontSize(14)
              .fontColor($r('[basic].color.white'))
          } else {
            Text('长按语音搜索')
              .fontSize(14)
              .fontColor($r('[basic].color.white'))
          }
        }
      }
      .padding({ left: 12, right: 12 })
      .height(36)
      .linearGradient({
        angle: 135,
        colors: [[$r('[basic].color.linear_begin'), 0], [$r('[basic].color.linear_end'), 1]]
      })
      .margin({ bottom: 16 })
      .gesture(
        LongPressGesture()
          .onAction(() => {
            // 开始录音
            this.startRecord()
          })
          .onActionEnd(() => {
            // 结束录音
            this.closeRecord()
          })
          .onActionCancel(() => {
            // 结束录音
            this.closeRecord()
          })
      )

    }
    .layoutWeight(1)
    .width('100%')
    .backgroundImage($r('app.media.search_bg'))
    .backgroundImageSize(ImageSize.Contain)
    .backgroundImagePosition(Alignment.Bottom)
    .onVisibleAreaChange([0, 1], () => {
      this.keyword = ''
      this.voiceState = VoiceState.DEFAULT
    })
  }
}