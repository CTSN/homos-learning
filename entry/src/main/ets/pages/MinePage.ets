import ColorConstants from '../constants/ColorConstants'

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

    }

  }
}