@Entry
@Component
struct Demo06Image {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // 鸿蒙中对于图片文件名非常严格: 不要中文/不要空格/不要特殊字符
      // 1. ☆自建目录☆: ets下面, 自己新建  / 代表 ets 目录
      Image('/static/cat3.png')
        .width(100)
      // 2. ☆Resource/base/media 下的目录☆ (官方推荐的)
      Image($r('app.media.dragon'))
        .width(120)

      // 3. Resource/rawfile 下的目录(了解)
      Image($rawfile('dog.webp'))
        .width(140)
      // 4. 网图: 预览器正常, 模拟器打不开 => 没有开启网络权限
      Image('https://ww2.sinaimg.cn/mw690/8864d5a6gy1hwmq5ne9hwj20sg16o4qp.jpg')
        .width(160)

      // 5. 字体图标(阿里巴巴矢量图标库) 支持改颜色
      Image($r('app.media.heart'))
        .width(50)
        .fillColor(Color.Orange)
      // 6. 系统内置
      Image($r('sys.media.person_shield'))
        .width(50)
    }
    .width('100%')
  }
}