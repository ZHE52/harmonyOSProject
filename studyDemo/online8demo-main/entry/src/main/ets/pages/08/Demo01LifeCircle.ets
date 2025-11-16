import { promptAction, router } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Demo01LifeCircle {
  // 只要是组件, 就有下面三个生命周期函数
  aboutToAppear(): void {
    // 一般用于异步请求 => 不会频繁请求, 一个页面创建后, 只加载一次
    console.log('LifeCircle组件创建')
  }
  onDidBuild(): void {
    console.log('LifeCircle组件构建完成')
  }
  aboutToDisappear(): void {
    console.log('LifeCircle组件销毁')
  }

  // 页面组件, 才有PageShow和PageHide
  onPageShow(): void {
    // 如果是实时性要求非常高的场景, 放在onPageShow中
    console.log('页面-PageShow')
  }
  onPageHide(): void {
    console.log('页面-Page隐藏')
  }
  onBackPress(): boolean | void {
    // 返回true, 代表不进行退出操作, 添加自己的逻辑
    promptAction.showDialog({
      title: '退出警告',
      message: '确认要进行退出么, 哥们!',
      buttons: [
        { text: '取消', color: '#000' },
        { text: '确认', color: '#f00' }
      ]
    }).then((result) => {
      // 这里根据前面操作完的结果, 进行判断
      // result.index 可以获取到选中的数组按钮的下标
      if (result.index === 1) {
        router.back() // 正常的返回功能
      }
    })
    return true
  }

  @Local isShow: boolean = true
  build() {
    Column() {
      Text('我是生命周期测试页')
      Button('跳转页面测试').onClick(() => {
        router.pushUrl({
          url: 'pages/08/Demo02LifeCircle'
        })
      })
      Button('切换').onClick((event: ClickEvent) => {
        this.isShow = !this.isShow
      })
      if (this.isShow) {
        HmList()
      }
    }
  }
}

@Component
struct HmList {
  aboutToAppear(): void {
    console.log('HmList组件构建')
  }
  aboutToDisappear(): void {
    console.log('HmList组件销毁')
  }
  build() {
    Text('我是黑马列表组件')
  }
}