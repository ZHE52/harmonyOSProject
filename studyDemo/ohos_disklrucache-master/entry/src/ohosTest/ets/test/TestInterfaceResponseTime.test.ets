/**
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
import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType } from '@ohos/hypium'
import { DiskLruCache } from '@ohos/disklrucache';
import { GlobalContext } from "../testability/GlobalContext";

export default function telephonyPerfJsunit(){
  describe("telephonyPerfJsunit", ()=>{
    const BASE_COUNT=2000
    const HTTP_COUNT=2
    const BASELINE_HASSIMECASR=500
    const BASELINE_CREATEHTTP=800
    const BASELINE_REQUEST=2500
    const BASELINE_DESTROY=30

    //SVGCircle
    it("create", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context : Context =GlobalContext.getContext().getObject("context")as Context
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {
      let cache :DiskLruCache =DiskLruCache.create(context)
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_create endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_create averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    //SVGDeclares
    it("EmlFormat", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGDeclares startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_EmlFormat endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_EmlFormat averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });


    it("setMaxSize", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.setMaxSize(12*1024*1024)
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_setMaxSize endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_setMaxSize averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });
    it("set", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.set('test' ,'Hello Word Simple Example.')
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_set endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_set averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    it("get", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.get('test')
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_get endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_get averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    it("getFileToPath", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.getFileToPath('test')
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_getFileToPath endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_getFileToPath averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    it("getPath", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.getPath()
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_getPath endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_getPath averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    it("deleteCacheDataByKey", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.deleteCacheDataByKey('test')
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_deleteCacheDataByKey endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_deleteCacheDataByKey averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

    it("cleanCacheData", TestType.PERFORMANCE, async (done:Function)=> {
      let startTime=new Date().getTime()
      let context:Context=GlobalContext.getContext().getObject("context")as Context
      let cache:DiskLruCache=DiskLruCache.create(context)
      console.log("Telephony_Http_CreateHttp_Perf_0100_SVGCircle startTime:"+startTime);

      for (let index = 0; index < BASE_COUNT; index++) {

        cache.cleanCacheData()
      }

      let endTime=new Date().getTime()
      console.log("Telephony_Http_CreateHttp_Perf_0100_cleanCacheData endTime:"+endTime);

      let averageTime=((endTime-startTime)*1000)/BASE_COUNT
      console.log("Telephony_Http_CreateHttp_Perf_0100_cleanCacheData averageTime:"+averageTime+"μs");
      expect(averageTime<BASELINE_CREATEHTTP).assertTrue();
      done()
    });

  })
}