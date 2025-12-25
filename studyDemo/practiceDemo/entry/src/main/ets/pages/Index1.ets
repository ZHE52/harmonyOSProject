// 文件路径: entry/src/main/ets/pages/Index1.ets

import { TopPinnedPanel } from '../pages/TopPinnedPanel';

class PinnedItem {
  id: number
  text: string
  constructor(id: number, text: string) {
    this.id = id
    this.text = text
  }
}

@Entry
@Component
struct Index1 {
  @State pinnedList: PinnedItem[] = [
    new PinnedItem(1, '郭国政: ffff'),
    new PinnedItem(2, '郭国政: jjjjjjjjjjj'),
    new PinnedItem(3, '郭国政: oooooooo'),
    new PinnedItem(4, '郭国政: 赞赞赞赞赞赞赞赞赞'),
    new PinnedItem(5, '郭国政: 得得得')
  ];
  @State private nextPinnedId: number = 6;

  private addPinned(text: string) {
    const next = [...this.pinnedList, new PinnedItem(this.nextPinnedId, text)];
    this.nextPinnedId += 1;
    this.pinnedList = next.length > 5 ? next.slice(next.length - 5) : next;
  }

  private removePinned(id: number) {
    this.pinnedList = this.pinnedList.filter(it => it.id !== id);
  }

  build() {
    Stack() {
      // 第1层: 主内容区 (现在是空的，只留一个背景色和测试按钮)
      Column() {
        // 为了方便你测试，我保留了这个按钮
        Button('点我新增一条置顶')
          .onClick(() => this.addPinned(`胡庆庆 ${this.nextPinnedId}: 新消息`))
          .margin({ top: 200 }); // 调整一下位置
      }
      .width('100%').height('100%')
      .justifyContent(FlexAlign.Start)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F2F3F5');

      // 第2层: 置顶面板组件
      Column() {
        TopPinnedPanel({
          pinnedList: $pinnedList,
          onRemoveItem: (id: number) => {
            this.removePinned(id);
          }
        })
      }
      .width('100%').position({ x: 0, y: 0 });
    }
    .width('100%').height('100%');
  }
}