import { auth } from "."
import { AppStorageV2 } from "@kit.ArkUI"
import { AppCart, CartGoodsModel } from "../viewmodels"
import { getCartCountAPI, getCartListAPI } from "../apis"


export class AuthCart {
  /**
   * 更新购物车总数量
   */
  async updateCartCount(){
    // 1. 获取token
    // 2. 判断是否有token
    // 3. 有token, 则获取购物车商品总数量, 没有token, 则总数量为0
    const user = auth.getUser()
    const appCart = AppStorageV2.connect(AppCart, ()=> new AppCart())!
    if(user.token){
      const res = await getCartCountAPI()
      appCart.count = res.count
      // Observed(class) ObjectLink ObservedV2 必须要通过new才具备响应式
      appCart.cartList = (await getCartListAPI()).map(item => new CartGoodsModel(item))
    }else {
      appCart.count = 0
      appCart.cartList = []
    }
  }
}


export const authCart = new AuthCart()