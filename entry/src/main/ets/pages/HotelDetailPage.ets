import ColorConstants from '../constants/ColorConstants'
import HotelBaseInfo from '../data/HotelDetailBean'
import HttpUtils from '../utils/HttpUtils'
import hilog from '@ohos.hilog'
import { PreferencesUtils } from '../utils/PreferencesUtils'
import HotelRoomListBean from '../data/HotelRoomListBean'
import { HotelRoomListComponent } from './HotelRoomListComponent'


@Extend(Text) function textStyle(textSize: number) {
  .fontSize(textSize)
  .fontColor(ColorConstants.COLOR_2D2F38)
}

//resolve和reject，分别表示异步操作成功和失败时的回调函数
//async/await是一种用于处理异步操作的Promise语法糖
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    const randomNumber = Math.random();
    if (randomNumber > 0.5) {
      resolve(randomNumber);
    } else {
      reject(new Error('Random number is too small'));
    }
  }, 1000)
})


@Entry
@Component
struct HotelDetailPage {

  /**
   * 基础信息
   */
  baseInfo: HotelBaseInfo

  aboutToAppear() {
    //请求详情接口
    let url = "https://dossen-nervous-hotel.test.dossen.com/hotel/detail/info"
    let request = {
      "appInfo": {
        "appKey": "Native-Android",
        "sysVerson": "11",
        "version": "5.0.20"
      },
      "roomPriceType": "NS",
      "brandCode": "yc",
      "labelChannel": "1",
      "hotelId": "0020122",
      "startDate": "2024-01-26",
      "appVersion": "5.0.20"
    };
    HttpUtils.post(url, request, (data: string) => {
      let json = JSON.parse(data)
      //如何转化为实体bean
      hilog.debug(0x001, "aboutToAppear", "=====>" + JSON.stringify(data))
    },null,null)


    // promise.then(result=>{
    //   console.info(`Random number is ${result}`);
    // }).catch(error=>{
    //   console.error(error.message);
    // })

    //存储信息 可以使用then方法和catch方法指定fulfilled状态和rejected状态的回调函数
    PreferencesUtils.putValue("test", "info").then(result => {

    }).catch(error => {

    })
  }

  onPageShow() {

  }

  @Builder getTagItem(tagName: string) {
    Text(tagName)
      .fontSize(11)
      .fontColor(ColorConstants.COLOR_6F7281)
  }

  build() {
    Scroll(){
      RelativeContainer() {

        Column() {
          this.getHeadLayout()
        }
        .id("head_layout")
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
        })
        .height(200)

        Text('臻程酒店武汉汉阳大道国博店')
          .alignRules({
            top: { anchor: 'head_layout', align: VerticalAlign.Bottom },
          })
          .margin({ left: 20, right: 20, top: 20, bottom: 10 })
          .textStyle(17)
          .fontWeight(FontWeight.Bold)
          .id("tv_title")

        //顶部对其标题底部
        Row({ space: 10 }) {
          this.getTagItem('高端型')
          this.getTagItem('2019年开业')
        }
        .margin({ left: 20, right: 20 })
        .alignRules(
          { top: { anchor: "tv_title", align: VerticalAlign.Bottom } }
        ).id("flow_layout")

        //右边-必须有id
        Text('设施/详情>')
          .fontSize(12)
          .fontColor(ColorConstants.COLOR_2D2F38)
          .margin({ right: 10 })
          .alignRules(
            {
              right: { anchor: '__container__', align: HorizontalAlign.End },
              top: { anchor: "tv_title", align: VerticalAlign.Bottom }
            })
          .id("tv_service")

        //评分、位置信息
        Row({ space: 10 }) {
          //评分
          this.getLeftItem()
          //位置信息
          this.getRightLayout()
        }.alignRules(
          { top: { anchor: "flow_layout", align: VerticalAlign.Bottom } }
        ).id("body_layout")
        .margin(20)

        //列表
        Column() {
          HotelRoomListComponent()
        }
        .alignRules({
          top: { anchor: "body_layout", align: VerticalAlign.Bottom },
          bottom: { anchor: "_container_", align: VerticalAlign.Bottom }
        })
        .id("list_layout")

      }.width('100%')
      .height('100%')
    }.scrollable(ScrollDirection.Vertical)
    .width('100%')
    .height('100%')
  }

  @Builder getLeftItem() {
    Column({ space: 10 }) {
      Row() {
        Text('4.8').textStyle(12)
          .padding(2)
          .backgroundColor("#16A185")
          .borderRadius(4)

        Text('超级棒').textStyle(12)
          .padding(2)
          .margin({ left: 5 })
      }

      Text('房间干净，位置很好').textStyle(12)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
      Text('20000评论').textStyle(12)
    }
    .backgroundColor(ColorConstants.COLOR_F0FAF8)
    .width("40%")
    .height(86)
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .borderRadius(6)
  }

  @Builder getRightLayout() {
    Stack() {
      //背景图
      Image($r('app.media.icon_card_bg'))
      //布局
      Row({ space: 10 }) {
        Column() {
          Text('汉阳区杨泗街246号世茂锦绣长江六期超').textStyle(12)
            .width(100)
            .fontWeight(FontWeight.Bold)
          Text('武汉国际博览中心…').textStyle(12)
        }.alignItems(HorizontalAlign.Start)
        //位置图标
        Image($r('app.media.icon_location')).height(24).width(24)
      }
    }
    .backgroundColor(ColorConstants.COLOR_F0FAF8)
    .width("60%")
    .height(86)
    .alignContent(Alignment.Start)
    .padding(12)
    .margin({ right: 20 })
    .borderRadius(6)
  }

  private swiperController: SwiperController = new SwiperController()

  //banner 按钮联动
  @Builder getHeadLayout() {
    Swiper(this.swiperController) {
      Image($r("app.media.icon_hotel_head"))
      Image($r("app.media.icon_hotel_head"))
    }.loop(true)
  }

  // @Builder getMemberRightLayout(){
  //
  // }

}