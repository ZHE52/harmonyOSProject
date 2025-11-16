import { RequestRcp } from "../utils";
import { AddCartParams, CartCount, CartGoodsModel,
  CreateOrderParams,
  CreateOrderResult,
  DeleteCartParams, PreOrder, UpdateCartParams } from "../viewmodels";


export const addCartAPI = (data: AddCartParams) => RequestRcp.post<null>("/member/cart", data)


// 获取购物车列表
export const getCartListAPI = () => RequestRcp.get<CartGoodsModel[]>("/member/cart")


// 获取购物车商品总数量
export const getCartCountAPI = () => RequestRcp.get<CartCount>('/member/cart/count')


// 修改单个购物车商品(数量和选中与否)
export const updateCartAPI =
  (skuId: string, data: UpdateCartParams) => RequestRcp.put<null>(`/member/cart/${skuId}`, data)


// 全选和取消全选
export const selectOrUnSelectAPI = (data: UpdateCartParams) => RequestRcp.put<null>("/member/cart/selected", data)

// 根据skuID删除购物车商品
export const delCartAPI = (data: DeleteCartParams) => RequestRcp.delete<null>("/member/cart", undefined, data)


// 获取结算信息
export const getPreOrderAPI = () => RequestRcp.get<PreOrder>(`/member/order/pre`)

// 下订单
export const createOrderAPI = (data: CreateOrderParams) => RequestRcp.post<CreateOrderResult>("/member/order", data)
