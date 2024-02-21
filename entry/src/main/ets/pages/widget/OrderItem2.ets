import router from '@ohos.router'
import ColorConstants from '../../constants/ColorConstants'
import { MainOrderData } from '../../data/HomeOrderList'
import { OrderData } from '../../data/OrderData'

@Component
export struct OrderItem2 {
  @State itemHeight: number = 115
  @State paddingBottom: number = 10
  // order: MainOrderData
  data: OrderData
  @State show: Visibility = Visibility.Hidden

  getStatus(status: number) {
    switch (status) {
      case 1:
        return "待支付"
      case 2:
        return "已支付"
      case 3:
        return "待入住"
      default:
        return ""
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Image($r('app.media.bac'))
        .borderRadius(8)
        .width('100%')
        .id('iv_bac')

      Column() {
        Text(this.getStatus(this.data.status))
          .borderRadius({ topLeft: 6, bottomRight: 6, topRight: 0, bottomLeft: 0 })
          .backgroundColor(ColorConstants.COLOR_4016a185)
          .fontColor(ColorConstants.COLOR_16A185)
          .fontSize(11)
          .textAlign(TextAlign.Center)
          .width(46)
          .padding({ top: 2, bottom: 2 })

        //中间布局
        Flex() {
          Column() {
            Text(this.data.title)
              .margin({ left: 10, top: 2 })
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorConstants.COLOR_2D2F38)
              .maxLines(1)
              .fontSize(14)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(this.data.detail)
              .fontWeight(300)
              .fontColor(ColorConstants.COLOR_2D2F38)
              .maxLines(1)
              .fontSize(11)
              .margin({ top: 2, left: 10 })
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Row() {
              Text(this.data.startDate)
                .fontSize(12)
                .fontColor(ColorConstants.COLOR_2D2F38)
              Text('  入住 - ')
                .fontSize(11)
                .fontColor(ColorConstants.COLOR_2D2F38)
              Text(this.data.endDate)
                .fontSize(12)
                .fontColor(ColorConstants.COLOR_2D2F38)
              Text('  离店')
                .fontSize(11)
                .fontColor(ColorConstants.COLOR_2D2F38)
            }
            .margin({ left: 10, top: 3 })
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)

          Row() {
            Column() {
              Image($r('app.media.icon_map'))
                .width(26)
              Text('地图')
                .fontColor(ColorConstants.COLOR_2D2F38)
                .margin({ top: 3 })
                .fontSize(10)
            }
            .width(26).margin({ right: 11 })

            Column() {
              Image($r('app.media.icon_phone'))
                .width(26)
              Text('电话')
                .fontColor(ColorConstants.COLOR_2D2F38)
                .margin({ top: 3 })
                .fontSize(10)
            }
            .width(26)
          }
          .margin({ left: 8, top: 10, right: 11 })
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.End)
        }.width('100%')

        //底部按钮布局
        Row() {
          Text('去支付')
            .border({ color: ColorConstants.COLOR_E35A43, width: 0.5 })
            .borderRadius(4)
            .padding({ left: 10, right: 10, top: 3, bottom: 3 })
            .fontSize(10)
            .margin({ left: 10, top: 9 })
            .fontColor(ColorConstants.COLOR_E35A43)
            .id('tv_pay')
        }.width('100%')
      }.width('100%').height('100%').alignItems(HorizontalAlign.Start)

      //关闭按钮
      Row() {
        Image($r('app.media.icon_close'))
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })
          .padding(6)
          .width(22)
          .id('iv_close')
      }.width('100%').justifyContent(FlexAlign.End).onClick(event => {
        this.itemHeight = 0
        this.paddingBottom = 0
      })

      // Column()
      //   .width('100%')
      //   .height('100%')
      //   .backgroundColor(Color.White)
      //   .borderRadius(8)
      //   .visibility(this.show)
    }.width('100%').height(this.itemHeight)
    .padding({ bottom: this.paddingBottom })
    .animation({ duration: 1000, curve: Curve.Ease })
    .onClick(() => {
      console.log("点击了新页面,压栈保留当前页面")
      router.pushUrl({ url: "pages/HotelDetailPage" }, router.RouterMode.Standard, (err) => {
        console.log(`出错了${err}`)
      })
    })
  }
}