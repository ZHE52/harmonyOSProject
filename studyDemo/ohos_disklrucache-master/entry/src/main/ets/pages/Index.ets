/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { DiskLruCache } from '@ohos/disklrucache'
import fs from '@ohos.file.fs';
import { GlobalContext } from "../entryability/GlobalContext"


@Entry
@Component
struct Index {
  @State imageSrc: string | undefined = undefined
  testDiskLruCache: DiskLruCache | undefined = undefined
  @State logText: string = '打印日志结果'
  private gloContext: Context = GlobalContext.getContext().getObject("context") as Context

  build() {
    Scroll() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        Text("测试DiskLruCache能力")
          .backgroundColor(Color.Blue)
        Button("设置DiskLruCache大小12M")
          .onClick(() => {
            if (this.testDiskLruCache !== undefined) {
              this.testDiskLruCache.setMaxSize(12 * 1024 * 1024)
            }
          }).margin({ top: 15, bottom: 15 })

        Button("设置DiskLruCache大小30M")
          .onClick(() => {
            if (this.testDiskLruCache !== undefined) {
              this.testDiskLruCache.setMaxSize(30 * 1024 * 1024)
            }
          }).margin({ top: 15, bottom: 15 })

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button("加载png到磁盘1.64mb")
            .onClick(() => {
              this.addFileToDisk('png', $r('app.media.pngSample').id)
            }).margin({ top: 5, bottom: 10 })
          Button("加载gif到磁盘9.45mb")
            .onClick(() => {
              this.addFileToDisk('gif', $r('app.media.gifSample').id)
            }).margin({ top: 5, bottom: 10 })
          Button("加载jpg到磁盘3.86mb")
            .onClick(() => {
              this.addFileToDisk('jpg', $r('app.media.jpgSample').id)
            }).margin({ top: 5, bottom: 10 })
          Button("加载bmp到磁盘1.92mb")
            .onClick(() => {
              this.addFileToDisk('bmp', $r('app.media.bmpSample').id)
            }).margin({ top: 5, bottom: 10 })
        }.height(60).backgroundColor(Color.Pink)

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button("获取1.64mb的png")
            .onClick(() => {
              this.getFileTopPixelMap('png', 'pngSample')
            }).margin({ top: 5, bottom: 10 })
          Button("获取9.45mb的gif")
            .onClick(() => {
              this.getFileTopPixelMap('gif', 'gifSample')
            }).margin({ top: 5, bottom: 10 })
          Button("获取3.86mb的jpg")
            .onClick(() => {
              this.getFileTopPixelMap('jpg', 'jpgSample')
            }).margin({ top: 5, bottom: 10 })
          Button("获取1.92mb的bmp")
            .onClick(() => {
              this.getFileTopPixelMap('bmp', 'bmpSample')
            }).margin({ top: 5, bottom: 10 })
        }.height(60).backgroundColor(Color.Pink)

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Button("删除png数据")
            .onClick(() => {
              this.deleteCacheDataKey('png')
            }).margin({ top: 5, bottom: 10 })
          Button("删除gif数据")
            .onClick(() => {
              this.deleteCacheDataKey('gif')
            }).margin({ top: 5, bottom: 10 })
          Button("删除jpg数据")
            .onClick(() => {
              this.deleteCacheDataKey('jpg')
            }).margin({ top: 5, bottom: 10 })
          Button("删除bmp数据")
            .onClick(() => {
              this.deleteCacheDataKey('bmp')
            }).margin({ top: 5, bottom: 10 })
          Button("删除所有数据")
            .onClick(() => {
              this.cleanCacheData()
            }).margin({ top: 5, bottom: 10 })
        }.height(60).backgroundColor(Color.Pink)

        Scroll() {
          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
            Text(this.logText).fontSize(15).width(300)
            Image(this.imageSrc)
              .width(300)
              .visibility(this.imageSrc === undefined ? Visibility.None : Visibility.Visible)
          }
        }.width(600).height(300).margin({ top: 20 }).backgroundColor(Color.Pink)
      }
    }
  }

  aboutToAppear() {
    // 默认缓存大小300M
    this.testDiskLruCache = DiskLruCache.create(this.gloContext)
  }

  showLog(disk: DiskLruCache) {
    //查看DiskLruCache数据
    let showDisk: string = ''
    disk.foreachDiskLruCache((value: string, key: number, map: string[]) => {
      showDisk += 'key=' + key + '&value=' + value;
    })
    this.logText = '日志结果:' + showDisk;
  }

  addFileToDisk(key: string, resId: number) {
    this.gloContext.resourceManager.getMedia(resId)
      .then(data => {
        let arrayBuffer = this.typedArrayToBuffer(data);
        let value: boolean | ArrayBuffer = true
        if (this.testDiskLruCache !== undefined) {
          value = this.testDiskLruCache.get(key);
          if (value) {
          } else {
            if (this.testDiskLruCache !== undefined) {
              this.testDiskLruCache.set(key, arrayBuffer)
            }
          }
          this.showLog(this.testDiskLruCache)
        }
      })
      .catch((err: Error) => {
        console.log('addFileToDisk err=' + err)
      })
  }

  getFileTopPixelMap(key: string, name: string) {
    if (this.testDiskLruCache !== undefined) {
      this.testDiskLruCache.getFileToPathAsync(key).then((data) => {
        let index: number = data.lastIndexOf('/')
        let newPath: string = data.substring(0, index) + '/' + name + '.' + key
        fs.copyFileSync(data, newPath)
        this.imageSrc = 'file://' + newPath
      }).catch((err: Error) => {
        this.imageSrc = undefined
        console.log('getFileToPixelMap err = ' + err)
      })
    }
  }

  deleteCacheDataKey(key: string) {
    if (this.testDiskLruCache !== undefined) {
      this.testDiskLruCache.deleteCacheDataByKey(key);
      this.showLog(this.testDiskLruCache);
      this.imageSrc = this.testDiskLruCache.get(key) === null ? undefined : '';
    }
  }

  cleanCacheData() {
    if (this.testDiskLruCache !== undefined) {
      this.testDiskLruCache.cleanCacheData();
      this.showLog(this.testDiskLruCache);
      this.imageSrc = this.testDiskLruCache.getSize() === 0 ? undefined : '';
    }
  }

  typedArrayToBuffer(array: Uint8Array) {
    return array.buffer.slice(array.byteOffset, array.byteLength + array.byteOffset)
  }
}