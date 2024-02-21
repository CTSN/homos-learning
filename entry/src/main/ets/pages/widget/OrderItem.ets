import window from '@ohos.window'
import ColorConstants from '../../constants/ColorConstants'
import { OrderData } from '../../data/OrderData';
import { LoadingDialog } from './dialog/LoadingDialog'
import router from '@ohos.router';
import HttpUtils from '../../utils/HttpUtils';
import hilog from '@ohos.hilog';
import BaseResponse from '../../data/BaseResponse';
import HomeOrderList, { MainOrderData } from '../../data/HomeOrderList';

// Get context.
let context = getContext(this);

@Component
export struct OrderItem {
  // order: MainOrderData
  data: OrderData
  @State itemWidth: number = 0;
  @State itemHeight: number = 105;
  @State screenWidth: number = 0;
  @State bottom: number = 10;

  aboutToAppear() {
    // window.getLastWindow(context)
    //   .then((windowClass: window.Window) => {
    //     let windowPro = windowClass.getWindowProperties()
    //     this.screenWidth = px2vp(windowPro.windowRect.width)
    //     this.itemWidth = this.screenWidth - 20;
    //     this.itemHeight = this.itemWidth / 343 * 120;
    //   })
  }

  hideItem() {
    animateTo({ duration: 1000, curve: Curve.Ease }, () => {
      this.itemHeight = 0
      this.bottom = 0
    });
  }

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
    RelativeContainer() {
      Image($r('app.media.bac'))
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
        })
        .borderRadius(8)
        .width('100%')
        .id('iv_bac')

      Image($r('app.media.icon_close'))
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          right: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .padding(6)
        .width(22)
        .onClick(() => {
          this.hideItem()
        })
        .id('iv_close')

      Column() {
        Image($r('app.media.icon_phone'))
          .width(26)
        Text('电话')
          .fontColor(ColorConstants.COLOR_2D2F38)
          .margin({ top: 3 })
          .fontSize(10)
      }
      .alignRules({
        right: { anchor: '__container__', align: HorizontalAlign.End }
      })
      .width(26)
      .margin({ top: 34, right: 11 })
      .id('item_phone')

      Column() {
        Image($r('app.media.icon_map'))
          .width(26)
        Text('地图')
          .fontColor(ColorConstants.COLOR_2D2F38)
          .margin({ top: 3 })
          .fontSize(10)
      }
      .alignRules({
        right: { anchor: 'item_phone', align: HorizontalAlign.Start }
      })
      .width(26)
      .margin({ top: 34, right: 11 })
      .id('item_map')

      Text(this.getStatus(this.data.status))
        .borderRadius({ topLeft: 6, bottomRight: 6, topRight: 0, bottomLeft: 0 })
        .backgroundColor(ColorConstants.COLOR_4016a185)
        .fontColor(ColorConstants.COLOR_16A185)
        .fontSize(11)
        .textAlign(TextAlign.Center)
        .width(46)
        .alignRules({
          top: { anchor: 'iv_bac', align: VerticalAlign.Top },
        })
        .id('tv_status')

      Text(this.data.title)
        .alignRules({
          top: { anchor: 'tv_status', align: VerticalAlign.Bottom },
          left: { anchor: '__container__', align: HorizontalAlign.Start },
          right: { anchor: 'item_map', align: HorizontalAlign.Start }
        })
        .margin({ left: 10, top: 2 })
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorConstants.COLOR_2D2F38)
        .maxLines(1)
        .fontSize(14)
        .padding({ top: 2, bottom: 2 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .id('tv_title')

      Text(this.data.detail)
        .alignRules({
          top: { anchor: 'tv_title', align: VerticalAlign.Bottom },
          left: { anchor: 'tv_title', align: HorizontalAlign.Start },
          right: { anchor: 'item_map', align: HorizontalAlign.Start }
        })
        .fontWeight(300)
        .fontColor(ColorConstants.COLOR_2D2F38)
        .maxLines(1)
        .fontSize(11)
        .margin({ top: 2, left: 10, right: 10 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .id('tv_detail')

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
      .alignRules({
        top: { anchor: 'tv_detail', align: VerticalAlign.Bottom },
        left: { anchor: 'tv_detail', align: HorizontalAlign.Start }
      })
      .margin({ left: 10, top: 3 })
      .id('col_date')
      .width('100%')

      Text('去支付')
        .border({ color: ColorConstants.COLOR_E35A43, width: 0.5 })
        .borderRadius(4)
        .padding({ left: 10, right: 10, top: 3, bottom: 3 })
        .alignRules({
          top: { anchor: 'col_date', align: VerticalAlign.Bottom }
        })
        .fontSize(10)
        .margin({ left: 10, top: 9 })
        .fontColor(ColorConstants.COLOR_E35A43)
        .id('tv_pay')
    }
    .width('100%')
    .height(this.itemHeight)
    .margin({ bottom: this.bottom })
    .onClick(() => {
      console.log("点击了新页面,压栈保留当前页面")
      router.pushUrl({ url: "pages/HotelDetailPage" }, router.RouterMode.Standard, (err) => {
        console.log(`出错了${err}`)
      })
    })
  }
}