import {TabItem,Logger} from 'basic';
import { CartView } from 'cart'
import { CategoryView } from 'category'
import { HomeView } from 'home'
import { MyView } from 'my'




//为什么要定义这个接口呢
interface TabItem1 {
  text:string,
  icon:ResourceStr,
  active:ResourceStr
}


@Entry
@ComponentV2
struct Index {
  aboutToAppear(): void {
    Logger.info({
      name: '鸿蒙牛逼',
      age: 18
    })
  }
  @Local
  activeIndex: number = 0
  list: TabItem[] = [//底部tab栏
    { text: '首页', normal: $r('app.media.ic_public_home_normal'), active: $r('app.media.ic_public_home_active') },//normal是原来颜色，active是高亮颜色
    { text: '分类', normal: $r('app.media.ic_public_pro_normal'), active: $r('app.media.ic_public_pro_active') },
    { text: '购物袋', normal: $r('app.media.ic_public_cart_normal'), active: $r('app.media.ic_public_cart_active') },
    { text: '我的', normal: $r('app.media.ic_public_my_normal'), active: $r('app.media.ic_public_my_active') },


  ]


//  list1:TabItem1[]=[
//    {text:'首页1',icon:$r('app.media.ic_public_home_normal'),active:$r('app.media.ic_public_home_active')},
//    {text:'分类11',icon:$r('app.media.ic_public_pro_normal'),active:$r('app.media.ic_public_pro_active')},
//     {text:'购物袋1',icon:$r('app.media.ic_public_cart_normal'),active:$r('app.media.ic_public_cart_active')},
//     {text:'我的1',icon:$r('app.media.ic_public_my_normal'),active:$r('app.media.ic_public_my_active')},
//   {text:'我的12',icon:$r('app.media.ic_public_my_normal'),active:$r('app.media.ic_public_my_active')}//可以一直写下去
//
// ]
  @Builder//自定义组件是吗
  getTabItemBuilder(item: TabItem, index: number) {//直接用这个getTabItemBuilder
    Column() {
      Image(this.activeIndex === index ? item.active : item.normal)
        .width(24)
        .aspectRatio(1)
      Text(item.text)// 跨 HSP 访问资源，需要在 oh-package.json5中导入
        //.fontColor($r('[basic].color.black'))
        .fontSize(12)
    }
    .justifyContent(FlexAlign.SpaceEvenly)//均等分，也就是竖着着等分，那横着呢？
    .height(50)
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: $$this.activeIndex }) {
      ForEach(this.list, (item: TabItem, index: number) => {
        TabContent() {

        }
        .tabBar(this.getTabItemBuilder(item, index))
      })
    }
    .scrollable(false)
  }
}


