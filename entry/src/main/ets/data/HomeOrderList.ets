import List from '@ohos.util.List'

export default class HomeOrderList {
  tripOrderListVos: Array<MainOrderData>
  homeReservationOrderVos: Array<ReservationOrder>
}

export class MainOrderData{
  reservationOrder: ReservationOrder
}

export class ReservationOrder {
  orderId: string
  startDate: string
  endDate: string
  hotel: HotelInfo
  orderStatusTag: OrderStatusTag
  hotelServices: List<HotelService>
}

export class HotelInfo {
  name: string
  address: string
}

export class OrderStatusTag {
  key: string
  value: string
}

export class HotelService{
  static PAY = "pay"   //去支付
  static ORDER_DETAIL = "orderDetail" //订单详情
  static MORE_SERVICE = "moreService"  //更多服务

  code: String
  name: String
  linkUrl: String
}