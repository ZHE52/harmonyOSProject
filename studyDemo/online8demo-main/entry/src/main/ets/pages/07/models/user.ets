export interface IUser {
  name: string
  age: number
}

@ObservedV2
export class User {
  @Trace name: string // 需要做响应式  this.user.name = 'xxx'  => 更新页面/持久化到本地
  @Trace age: number // 不需要响应式  this.user.age++  => 不会更新页面/不会自动持久化到本地 => 需要手动save
  constructor(obj: IUser) {
    this.name = obj.name
    this.age = obj.age
  }
}