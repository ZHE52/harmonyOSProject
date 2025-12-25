// 文件路径: entry/src/main/ets/components/TopPinnedPanel.ets

class PinnedItem {
  id: number
  text: string
  constructor(id: number, text: string) {
    this.id = id
    this.text = text
  }
}

@Component
export struct TopPinnedPanel {
  @Link pinnedList: PinnedItem[];
onRemoveItem: (id: number) => void = (id: number) => {};
  @State private panelExpanded: boolean = false;

  private togglePanel() {
    animateTo({ duration: 220, curve: Curve.EaseInOut }, () => {
      this.panelExpanded = !this.panelExpanded;
    });
  }

  build() {
    // 列表面板现在是组件的根节点
    Column() {
      // 列表区域
      Column() {
        ForEach(
          this.panelExpanded
            ? [...this.pinnedList].reverse().slice(0, 5)
            : [...this.pinnedList].reverse().slice(0, 1),
          (it: PinnedItem) => {
            ListItem() {
              Row() {
                Text('◎').fontSize(18).fontColor('#F5A623').margin({ right: 10 });
                Text(it.text).fontSize(16).fontColor('#222').maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis }).layoutWeight(1);
                Text('移除').fontSize(14).fontColor('#4A90E2')
                  .padding({ left: 10, right: 6, top: 8, bottom: 8 })
                  .onClick(() => this.onRemoveItem(it.id));
              }
              .width('100%').height(56).padding({ left: 14, right: 14 });
            }
          }, (it: PinnedItem) => String(it.id))
      }
      .width('100%');

      // 展开/收起按钮
      Row() {
        Text(this.panelExpanded ? '⌃' : '⌄')
          .fontSize(18).fontColor('#666').width(34).height(34)
          .textAlign(TextAlign.Center).backgroundColor('#F2F3F5').borderRadius(17);
      }
      .width('100%').height(44).justifyContent(FlexAlign.Center)
      .onClick(() => this.togglePanel());
    }
    .width('100%').backgroundColor(Color.White).borderRadius(14)
    .margin({ left: 16, right: 16, top: 12 }).clip(true); // 增加一个顶部 margin
  }
}