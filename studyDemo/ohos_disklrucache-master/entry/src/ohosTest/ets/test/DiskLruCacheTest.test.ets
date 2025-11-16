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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import { DiskLruCache, DiskCacheEntry } from '@ohos/disklrucache';
import fs from '@ohos.file.fs';
import { GlobalContext } from "../testability/GlobalContext"



export default function DiskLruCacheTest() {

  describe('DiskLruCacheTest', () => {
    it('set', 0, () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      cache.set('testABC', "Hello World ABC");
      cache.set('testDE', "Hello World Simple DE");
      expect(String.fromCharCode(...new Uint8Array(cache.get('test'))) == "Hello World Simple Example.")
        .assertTrue()
      expect(String.fromCharCode(...new Uint8Array(cache.get('testABC'))) == "Hello World ABC").assertTrue()
      expect(String.fromCharCode(...new Uint8Array(cache.get('testDE'))) == "Hello World Simple DE")
        .assertTrue()
      cache.cleanCacheData();
    })

    it('getAsync', 1, () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let data = GlobalContext.getContext().getObject("filesDir") as string
      let cache: DiskLruCache = DiskLruCache.create(context);
      let path = data + '/testFile.txt';
      let file = fs.openSync(path, 0o102);
      fs.writeSync(file.fd, "hello, world!");
      let length = fs.statSync(path).size;
      let dataArr = new ArrayBuffer(length);
      fs.readSync(file.fd, dataArr);
      cache.set('testFile', dataArr);
      expect(cache.get('testFile').byteLength == 13).assertTrue()
      cache.cleanCacheData();
    })

    it('setAsync', 2, async () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      let value: string = "Hello World Simple Example."
      await cache.setAsync('testsetAsync', value)
      await cache.getAsync('testsetAsync').then((data) => {
        expect(String.fromCharCode(...new Uint8Array(data)) == "Hello World Simple Example.").assertTrue()
      })
      expect(String.fromCharCode(...new Uint8Array(cache.get('testsetAsync'))) == "Hello World Simple Example.")
        .assertTrue()
      cache.cleanCacheData();
    })

    it('deleteCacheDataByKey', 3, () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      cache.set('testABC', "Hello World ABC");
      expect(String.fromCharCode(...new Uint8Array(cache.get('test'))))
        .assertEqual("Hello World Simple Example.");
      expect(String.fromCharCode(...new Uint8Array(cache.get('testABC')))).assertEqual("Hello World ABC");
      cache.deleteCacheDataByKey('test');
      cache.deleteCacheDataByKey('testABC');
      expect(String.fromCharCode(...new Uint8Array(cache.get('test')))).assertEqual('');
      expect(String.fromCharCode(...new Uint8Array(cache.get('testABC')))).assertEqual('');
      cache.cleanCacheData();
    })

    it('cleanCacheData', 4, () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      cache.set('testABC', "Hello World ABC");
      cache.set('testDE', "Hello World Simple DE");
      expect(String.fromCharCode(...new Uint8Array(cache.get('test'))))
        .assertEqual("Hello World Simple Example.")
      expect(String.fromCharCode(...new Uint8Array(cache.get('testABC')))).assertEqual("Hello World ABC")
      expect(String.fromCharCode(...new Uint8Array(cache.get('testDE')))).assertEqual("Hello World Simple DE")
      cache.cleanCacheData();
      expect(String.fromCharCode(...new Uint8Array(cache.get('test')))).assertEqual('')
      expect(String.fromCharCode(...new Uint8Array(cache.get('testABC')))).assertEqual('')
      expect(String.fromCharCode(...new Uint8Array(cache.get('testDE')))).assertEqual('')
    })

    it('Path', 5, async () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      let path: string = ''
      await cache.getFileToPathAsync('test').then((data) => {
        path = data
      })
      expect(String.fromCharCode(...new Uint8Array(cache.get('test'))) == "Hello World Simple Example.")
        .assertTrue()
      expect(cache.getFileToPath('test') == path).assertTrue()
      expect(cache.getPath() + cache.getCacheMap().getFirstKey() == path).assertTrue()
      cache.cleanCacheData();
    })

    it('getCacheMap', 6, async () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      expect(cache.getCacheMap().getFirstKey() == '098f6bcd4621d373cade4e832627b4f6').assertTrue()
      expect(cache.getCacheMap().hasKey('098f6bcd4621d373cade4e832627b4f6') == true).assertTrue()
      cache.cleanCacheData();
    })

    it('getSize', 7, async () => {
      let context: Context = GlobalContext.getContext().getObject("context") as Context
      let cache: DiskLruCache = DiskLruCache.create(context);
      cache.set('test', "Hello World Simple Example.");
      expect(String.fromCharCode(...new Uint8Array(cache.get('test'))) == "Hello World Simple Example.")
        .assertTrue()
      expect(cache.getSize() == 27).assertTrue()
      cache.cleanCacheData();
    })

    it('DiskCacheEntry', 8, async () => {
      let dentry = new DiskCacheEntry('test', 30 * 1024 * 1024)
      expect(dentry.getKey() == 'test').assertTrue()
      dentry.setKey('newtest')
      expect(dentry.getKey() == 'newtest').assertTrue()
      expect(dentry.getLength() == 30 * 1024 * 1024).assertTrue()
      dentry.setLength(12 * 1024 * 1024)
      expect(dentry.getLength() == 12 * 1024 * 1024).assertTrue()
      expect(dentry.toString() == dentry.getKey() + ' - ' + dentry.getLength()).assertTrue()
    })
  })
}
