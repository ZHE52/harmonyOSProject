@Entry
@Component
struct Demo02LifeCircle {
  // 只要是组件, 就有下面三个生命周期函数
  aboutToAppear(): void {
    console.log('页面2-组件创建')
  }
  onDidBuild(): void {
    console.log('页面2-组件构建完成')
  }
  aboutToDisappear(): void {
    console.log('页面2-组件销毁')
  }

  // 页面组件, 才有PageShow和PageHide
  onPageShow(): void {
    console.log('页面2-PageShow')
  }
  onPageHide(): void {
    console.log('页面2-Page隐藏')
  }

  build() {
    Column() {
      Text('我是生命周期测试页2')
    }
  }
}