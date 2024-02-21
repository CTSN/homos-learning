import HotelRoomListBean from '../data/HotelRoomListBean'

//自定义组件生命周期介绍
//https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V2/arkts-custom-component-lifecycle-0000001482395076-V2
@Component
export struct HotelRoomListComponent {
  aboutToDisappear() {
    //接口请求
  }

  private roomList = [
    new HotelRoomListBean('小明', $r("app.media.icon_default_hotel"), ["1", '2', '3']),
    new HotelRoomListBean('小王', $r("app.media.icon_default_hotel"), ["1", '2', '3'])
  ]
  // @State
  // private show: Visibility = Visibility.None
  @State
  private currentIndex: number = -1

  //  //ListItemGroup 支持分组列表
  build() {
    List() {
      //遍历
      ForEach(this.roomList, (item: HotelRoomListBean, index: number) => {
        //一级list
        ListItemGroup({ header: this.itemGroup(item, index) }) {
          //二级list
          ForEach(item.list, (childItem: string) => {
            ListItem() {
              this.itemChild(childItem, index)
            }
          })
        }
      })
    }.listDirection(Axis.Vertical).divider({ strokeWidth: 1, color: '#ffe9f0f0' })
    .scrollBar(BarState.Auto)
  }

  @Builder itemGroup(item: HotelRoomListBean, index: number) {
    Row() {
      Image(item.icon)
        .width(80)
        .height(80)
        .margin(10)

      Column() {
        Text(item.name).fontSize(15)
        Text('大床 有窗 102m').fontSize(14).margin({ top: 10 })
      }
      .justifyContent(FlexAlign.Start)

      Text('门市价').fontSize(14).visibility(Visibility.Hidden)
    }.padding(12).justifyContent(FlexAlign.Start)
    .width('100%')
    .onClick(() => {
      console.log("点击展开，显示二级list--如何只控制对应的子list隐藏显示")
      if (this.currentIndex != index) {
          this.currentIndex = index
      } else {
          this.currentIndex = -1
      }
    })
  }

  @Builder itemChild(item: string, index: number) {
    Row() {
      Text(item).fontSize(15)
    }.padding(20)
    .visibility(this.currentIndex === index ? Visibility.Visible : Visibility.None)
  }
}