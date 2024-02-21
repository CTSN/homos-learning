import ColorConstants from '../constants/ColorConstants'
import { Index } from './Index'
import { MinePage } from './MinePage'

@Entry
@Component
struct Page {

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      //非自定义的
      // TabContent() {
      //   Index()
      // }.tabBar("")

      TabContent() {
        Index()
      }.tabBar(this.TabBuild("首页", 0, $r('app.media.ic_bar_main_selected')
        , $r('app.media.ic_bar_main_unselected')))

      TabContent() {
        MinePage()
      }.tabBar(this.TabBuild("我的", 1, $r('app.media.ic_bar_main_selected')
        , $r('app.media.ic_bar_user_unselected')))
    }.onChange((index) => {
      this.currentIndex = index
    })
  }

  @State currentIndex: number = 0
  private tabController: TabsController = new TabsController()

  /**
   * 自定义导航-需要自己写联动
   * @param title
   * @param targetIndex
   * @param selectImg
   * @param normalImg
   */
  @Builder TabBuild(title: string, targetIndex: number, selectImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectImg : normalImg)
        .width(30)
        .height(30)
      Text(title)
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? ColorConstants.COLOR_E35A43 : ColorConstants.COLOR_2D2F38)
    }.width('100%')
    .height(50)
    //内容居中
    .justifyContent(FlexAlign.Center)
    //点击事件
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabController.changeIndex(this.currentIndex)
    })
  }
}