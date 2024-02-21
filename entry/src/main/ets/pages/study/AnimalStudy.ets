

//动画
//https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-animation-overview-0000001450755570-V3
@Entry
@Component
export struct AnimalStudy {

  //状态变化的对齐属性
  @State itemAlign: HorizontalAlign = HorizontalAlign.Start;
  allAlign: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End]
  alignIndex: number = 0

  build() {

    Column() {

      Column() {
        //自定义
        Path()
          .width(100)
          .height(100)
          .commands('M150 0 L300 300 L0 300 Z')
          .fill('#E87361')
          .stroke(Color.Blue)
      }.alignItems(this.itemAlign)
      .width('90%')

      Button("点击执行动画")
        .onClick(() => {
          //显式动画 仅仅执行1秒 平移动画
          animateTo({ duration: 1000, curve: Curve.EaseOut }, () => {
            this.alignIndex = (this.alignIndex + 1) % this.allAlign.length
            this.itemAlign = this.allAlign[this.alignIndex]
          })
        })

    }
    .padding(20)
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor("#ffffff")
    .width('100%')

  }
}