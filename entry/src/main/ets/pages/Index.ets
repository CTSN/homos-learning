import { OrderItem } from './widget/OrderItem'
import { OrderItem2 } from './widget/OrderItem2'
import HttpUtils from '../utils/HttpUtils'
import BaseResponse from '../data/BaseResponse'
import HomeOrderList, { MainOrderData } from '../data/HomeOrderList'
import { LoadingDialog } from './widget/dialog/LoadingDialog'
import ColorConstants from '../constants/ColorConstants'
import { OrderData } from '../data/OrderData'

@Entry
@Component
export struct Index {
  order1: OrderData = new OrderData(
    1, '广州珠江新城五羊邨地铁站宜尚Plus…Plus…Plus…Plus…Plus…', '广州市广州市越秀区五羊新村寺右新马路16', "2024-01-28", "2024-01-28"
  )
  order2: OrderData = new OrderData(
    2, '广州珠江新城五羊邨地铁站城市便捷城五羊邨地铁站城市', '广州市广州市越秀区五羊新村寺右新马路16', "2024-01-28", "2024-01-28"
  )
  /**
   * 列表数据
   */
  @State orderList: Array<MainOrderData> = new Array<MainOrderData>()

  /**
   * loading弹窗
   */
  dialogController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog(),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })

  /**
   * 页面创建
   */
  aboutToAppear() {
    this.getData()
  }

  /**
   * 获取列表数据
   */
  getData() {
    let url = 'https://dossen-nervous-order.test.dossen.com/trip/order/homeOrderList'
    let request = {
      "channel": "Native-android",
      "customerCode": "539864626427597579",
      "orderId": "",
      "version": "5.0.30"
    }
    HttpUtils.post(url, request, (data: string) => {
      let response: BaseResponse<HomeOrderList> = JSON.parse(data)
      if (response.code === 200) {
        let data = response.data
        if (data.tripOrderListVos.length > 0) {
          this.orderList = data.tripOrderListVos
        }
      }
      this.dialogController.close()
    }, () => {
      this.dialogController.open()
    }, () => {
      this.dialogController.close()
    })
  }

  /**
   * 构建布局
   */
  build() {
    Scroll() {
      Column() {
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        OrderItem({ data: this.order1 })
        OrderItem2({ data: this.order2 })
        // ForEach(this.orderList,(item : MainOrderData) => {
        //
        // },(item: MainOrderData, index: number) => index.toString())
      }.padding({ top: 10, left: 10, right: 14, bottom: 10 })
    }.scrollBar(BarState.Off).height('100%').width('100%').backgroundColor(ColorConstants.COLOR_F4F5FA)
  }
}