// import { AppBreakPoint, AppSafeArea, BreakPointType, HDMGoodsItem, ListDataSource, Logger, PAGE_PATH, HDMGoods } from 'basic'
// import { SearchParams, SearchRouterParam, SortCompAttr, SortField, SortMethod } from '../viewmodels'
// import { SearchSortItem } from '../components'
// import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
// import { AppStorageV2 } from '@kit.ArkUI'
// import { getSearchResultAPI } from '../apis/search'
//
//
// @HMRouter({ pageUrl: PAGE_PATH.SEARCH_RESULT_PAGE })
// @ComponentV2
// export struct SearchResultView {
//   breakPointClass: AppBreakPoint = AppStorageV2.connect(AppBreakPoint, () => new AppBreakPoint())!
//   safeArea: AppSafeArea = AppStorageV2.connect(AppSafeArea, () => new AppSafeArea())!
//   // 查询数据源
//   lazyDataSource: ListDataSource<HDMGoodsItem> = new ListDataSource()
//   // 查询参数
//   params: SearchParams = new SearchParams()
//   // 筛选条件
//   sortList: SortCompAttr[] = [
//     { label: '时间', field: 'publishTime' },
//     { label: '销量', field: 'orderNum' },
//     { label: '价格', field: 'price' }
//   ]
//   // 控制器
//   scroller = new Scroller()
//
//   // @Local
//   // list: HDMGoodsItem[] = []
//
//   // 是否正在加载
//   @Local
//   loading: boolean = false
//   // 是否加载完成
//   @Local
//   finished: boolean = false
//
//   aboutToAppear(): void {
//     // 接收上一个页面传递的参数
//     const params = HMRouterMgr.getCurrentParam() as SearchRouterParam
//     this.params.keyword = params.keyword
//     this.getSearchResult()
//   }
//
//   /**
//    * 获取搜索结果
//    */
//  async  getSearchResult(){
//     // 方案一
//    // const res =  await getSearchResultAPI({
//    //    keyword: this.params.keyword,
//    //    sortField: this.params.sortField,
//    //    sortMethod: this.params.sortMethod,
//    //    page: this.params.page,
//    //    pageSize: this.params.pageSize
//    //  })
//    // this.list = res.pageData.items
//
//    // 方案二: 正则替换
//    // const res = await getSearchResultAPI(JSON.parse(JSON.stringify(this.params).replace(/__ob_/g, "")) as SearchParams)
//    // this.list = res.pageData.items
//
//    // 方案三: 在请求拦截器中处理
//    const result = await getSearchResultAPI(this.params)
//    // this.list.push(...result.pageData.items)
//    this.lazyDataSource.pushData(result.pageData.items)
//
//    if(this.params.page >= result.pageData.pages){
//      this.finished = true
//    } else {
//      this.params.page++
//    }
//   }
//
//   /**
//    * 排序搜索
//    */
//   onRefresh(){
//     this.params.page = 1
//     // this.list = []
//     this.lazyDataSource.loadData([])
//     this.finished = false
//     this.getSearchResult()
//   }
//
//   build() {
//     Column() {
//       // 搜索区域
//       Row() {
//         Image($r('[basic].media.ic_public_left'))
//           .width(24)
//           .aspectRatio(1)
//           .fillColor($r('[basic].color.white'))
//           .margin(13)
//           .onClick(() => {
//             HMRouterMgr.pop()
//           })
//         Search({ placeholder: '商品关键字...', value: $$this.params.keyword })
//           .searchIcon({ src: $r('[basic].media.ic_public_search'), color: $r('[basic].color.gray') })
//           .placeholderColor($r('[basic].color.gray'))
//           .placeholderFont({ size: 14 })
//           .backgroundColor($r('[basic].color.white'))
//           .textFont({ size: 14 })
//           .layoutWeight(1)
//           .padding(0)
//           .margin(0)
//           .height(36)
//           .caretStyle({ color: $r('[basic].color.red') })
//           .onSubmit(() => {
//              this.params.page = 1
//              // this.list = []
//              this.lazyDataSource.loadData([])
//              this.finished = false
//              this.getSearchResult()
//           })
//       }
//       .padding({ top: this.safeArea.topHeight, right: 16 })
//       .linearGradient({
//         angle: 135,
//         colors: [[$r('[basic].color.linear_begin'), 0], [$r('[basic].color.linear_end'), 1]]
//       })
//
//       // list
//       Row() {
//         ForEach(this.sortList, (item: SortCompAttr) => {
//           // 筛选组件
//           SearchSortItem({
//             label: item.label,
//             field: item.field,
//             sortField: this.params.sortField,
//             sortMethod: this.params.sortMethod,
//             onSortChange: (field: SortField, method: SortMethod) => {
//               this.params.sortField = field  // 更新排序字段
//               this.params.sortMethod = method // 更新排序方法
//               // 重新拉取数据(下拉)
//               this.onRefresh()
//             }
//           })
//         })
//         Text('筛选')
//           .fontSize(14)
//           .fontColor($r('[basic].color.gray'))
//       }
//       .padding({ left: 16, right: 16 })
//       .height(50)
//       .width('100%')
//       .justifyContent(FlexAlign.SpaceBetween)
//       .border({ width: { bottom: 0.5 }, color: $r('[basic].color.border') })
//
//       WaterFlow({ scroller: this.scroller, footer: this.getFootBuilder() }) {
//         LazyForEach(this.lazyDataSource, (item: HDMGoodsItem) => {
//           FlowItem() {
//             HDMGoods({ goods: item, smallImage: true })
//           }
//         })
//         // Repeat<HDMGoodsItem>(this.list).each((obj:  RepeatItem<HDMGoodsItem>)=>{
//         //     FlowItem() {
//         //       HDMGoods({ goods: obj.item, smallImage: true })
//         //     }
//         // })
//         //   .virtualScroll()
//         //   .key((item: HDMGoodsItem, index: number)=> `${index}_${JSON.stringify(item)}`)
//       }
//       .columnsTemplate(
//         new BreakPointType({
//           sm: '1fr 1fr',
//           md: '1fr 1fr 1fr',
//           lg: '1fr 1fr 1fr 1fr'
//         })
//           .getValue(this.breakPointClass.breakPoint)
//       )
//       .columnsGap(0.5)
//       .rowsGap(0.5)
//       .layoutWeight(1)
//       // .height('100%')
//       .onReachEnd(async () => {
//          if(!this.loading && !this.finished){
//            this.loading = true
//            await this.getSearchResult()
//            this.loading = false
//          }
//       })
//     }
//   }
//
//   @Builder
//   getFootBuilder() {
//     Row({ space: 10 }) {
//       if (this.loading) {
//         Text("加载中...")
//           .fontSize(12)
//           .fontColor($r("[basic].color.gray"))
//         LoadingProgress()
//           .width(20)
//           .aspectRatio(1)
//       } else {
//         if (this.finished) {
//           Text("没有更多啦")
//             .fontSize(12)
//             .fontColor($r("[basic].color.gray"))
//         }
//       }
//     }
//     .justifyContent(FlexAlign.Center)
//     .width("100%")
//     .height(50)
//   }
//
// }
