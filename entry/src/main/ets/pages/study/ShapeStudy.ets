
import ColorConstants from '../../constants/ColorConstants';

//shape学习
//https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-geometric-shape-drawing-0000001503484809-V3
@Entry
@Component
export struct MinePage {

  //状态变化的对齐属性
  @State itemAlign: HorizontalAlign = HorizontalAlign.Start;
  allAlign: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End]
  alignIndex: number = 0

  build() {

    Column() {

      Shape() {
        Rect().width(300).height(50)
      }

      Circle({ width: 150, height: 150 })
        .fill(ColorConstants.COLOR_2D2F38).backgroundColor($r('app.color.red_color'))

      //自定义
      Path()
        .width(100)
        .height(100)
          //todo 这个描述
        .commands('M150 0 L300 300 L0 300 Z')
        .fill('#E87361')
        .stroke(Color.Blue)
    }
    .padding(20)
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor("#ffffff")
    .width('100%')

  }
}