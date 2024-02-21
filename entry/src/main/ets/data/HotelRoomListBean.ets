import List from '@ohos.util.List';
export default class HotelRoomListBean {
  name: string;
  icon: Resource;

  index:number

  list:Array<string>

  childList:[

  ]

  constructor(name: string, icon: Resource,list:Array<string>) {
    this.name = name;
    this.icon = icon;
    this.list = list;
  }
}