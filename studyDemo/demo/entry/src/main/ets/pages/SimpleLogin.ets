import router from '@ohos.router';

@Entry
@Component
struct SimpleLogin {
  build() {
    Column() {
      Text('简单登录页面')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 100, bottom: 50 })
      
      Button('登录')
        .width('80%')
        .height(50)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Index' });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
} 