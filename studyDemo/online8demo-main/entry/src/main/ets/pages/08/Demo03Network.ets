import { abilityAccessCtrl, common } from '@kit.AbilityKit'
import { geoLocationManager } from '@kit.LocationKit'

@Entry
@ComponentV2
struct Demo03Network {
  @Local result: geoLocationManager.Location = {} as geoLocationManager.Location

  aboutToAppear(): void {
    // 一进入页面, 立刻开始申请权限
  }
  build() {
    Column() {
      Text('网络图片:')
      Image('https://img0.baidu.com/it/u=1795437982,2245735538&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1372')
        .width(200)

      Button('向用户申请权限').onClick(() => {
        // 创建一个程序控制管理器
        const manager = abilityAccessCtrl.createAtManager()
        // 利用管理器, 向用户申请权限
        manager.requestPermissionsFromUser(getContext(), [
          "ohos.permission.APPROXIMATELY_LOCATION"
        ])
      })

      Button('获取经纬度').onClick(async () => {
        this.result = await geoLocationManager.getCurrentLocation()
      })

      Button('二次申请权限').onClick(() => {
        // 创建一个程序控制管理器
        const manager = abilityAccessCtrl.createAtManager()
        // 权限二次申请设置, 把当前这个权限弹出来, 让用户再次选择 (新API)
        manager.requestPermissionOnSetting(getContext(), [
          "ohos.permission.APPROXIMATELY_LOCATION"
        ])
      })

      // 跳转到设置页 => 演示: 跨应用跳转ability
      Button('跳转到系统设置页').onClick(() => {
        // context.startAbility
        const context = getContext() as common.UIAbilityContext
        context.startAbility({
          deviceId: '', // 本设备
          bundleName: 'com.huawei.hmos.settings', // 包名
          abilityName: 'com.huawei.hmos.settings.MainAbility', // Ability窗口
          uri: 'application_info_entry',
          parameters: {
            pushParams: 'com.example.online08project'
          }
        })
      })

      Text(`经纬度: ${this.result.latitude} ${this.result.longitude}`)
    }
  }
}