import { CartGoodsModel, CategoryItem } from "../viewmodels";
import { BreakPointEnum } from "./break_point";
import { Type } from "@kit.ArkUI";

// 断点工具类
@ObservedV2
export class AppBreakPoint {
  @Trace
  breakPoint: BreakPointEnum = BreakPointEnum.XS
}


// 封装一个工具 可以帮我们实现适配的更简单一点
interface BreakPointOption<T> {
  xs?: T
  sm?: T
  md?: T
  lg?: T
}

export class BreakPointType<T> {
  options: BreakPointOption<T> = {}

  constructor(opt: BreakPointOption<T>) {
    this.options = opt // 将传入的断点的值赋值给对象
  }

  getValue(breakPoint: BreakPointEnum): T {
    return (this.options as object)[breakPoint]
    // if (breakPoint === BreakPointEnum.XS) {
    //   return this.options.xs!
    // } else if (breakPoint === BreakPointEnum.SM) {
    //   return this.options.sm!
    // } else if (breakPoint === BreakPointEnum.MD) {
    //   return this.options.md!
    // } else {
    //   return this.options.lg!
    // }
  }
}


// 存储当前全局安全区的对象
@ObservedV2
export class AppSafeArea {
  @Trace
  topHeight: number = 0
  @Trace
  bottomHeight: number = 0
}


// 定义统一返回的结构体接口
export interface ResponseData<T> {
  code: string;
  msg: string;
  result: T;
}

@ObservedV2
export  class AppCategory {
  @Trace
  category: CategoryItem[] = []
}


// ----------全局存储用户信息的接口和类
export interface UserInfo {
  account: string
  avatar: string
  nickname: string
  token: string
}

@ObservedV2
export class HDMUser implements UserInfo {
  @Trace
  account: string = '';
  @Trace
  avatar: string = '';
  @Trace
  nickname: string = '';
  @Trace
  token: string = '';

  // constructor(model: UserInfo) {
  //   this.account = model.account
  //   this.avatar = model.avatar
  //   this.nickname = model.nickname
  //   this.token = model.token
  // }
}


@ObservedV2
export class AppUser {
  // 当缓存的对象为复杂数据类型时, 需要用@Type装饰器装饰这个类 保证不丢失
  @Type(HDMUser)
  @Trace
  user: HDMUser = new HDMUser()
}



export interface CartCount {
  count: number
}

@ObservedV2
export class AppCart {
  // 购物车商品总数量
  @Trace
  count: number = 0
  @Trace
  cartList: CartGoodsModel[] = [] // 全局购物车
}

// 编译 类型  运行

export interface DeleteCartParams {
  ids: string[]
}
