import { HMRouter, HMRouterMgr } from "@hadss/hmrouter";
import { AppSafeArea, GlobalVariable, Logger, PAGE_PATH } from "basic";
import { webview } from "@kit.ArkWeb";
import { AppStorageV2 } from "@kit.ArkUI";
import { DialogHelper } from "@pura/harmony-dialog";

@HMRouter({ pageUrl: PAGE_PATH.PAY_PAGE })
@ComponentV2
export struct PayView {
  safeArea: AppSafeArea = AppStorageV2.connect(AppSafeArea, () => new AppSafeArea())!
  controller: webview.WebviewController = new webview.WebviewController()
  orderId: string = "" // 订单号

  dialogKey: string = '' // 控制弹层的显示和隐藏

  aboutToAppear(): void {
    this.orderId = HMRouterMgr.getCurrentParam() as string
    this.openDialog()
  }

  openDialog(){
    this.dialogKey = DialogHelper.showLoadingDialog({
      loadColor: $r('[basic].color.white'),
      loadSize: 40,
      content: '正在唤起支付...'
    })
  }

  build() {
    Column() {
      Web({
        src: `${GlobalVariable.BASE_URL}/pay/wap/aliPay?orderId=${this.orderId}`,
        controller: this.controller
      })
        .onPageBegin((event)=>{
          if(event.url.includes('pay/redirect?payResult')){
            // 清除路由栈
            HMRouterMgr.getPathStack(PAGE_PATH.MAIN_PAGE_ID)?.clear()
            // 跳转到支付结果页面
            HMRouterMgr.push({
              pageUrl: PAGE_PATH.PAY_RESULT_PAGE,
              param: {
                orderId:  this.orderId,
                payResult: event.url.includes('payResult=true')
              }
            })
          }
        })
        .onPageEnd(()=>{
           setTimeout(()=>{
             DialogHelper.closeDialog(this.dialogKey)
           }, 3000)
        })
    }
    .width("100%")
    .height("100%")
    .padding({
      top: this.safeArea.topHeight,
      bottom: this.safeArea.bottomHeight
    })

  }
}