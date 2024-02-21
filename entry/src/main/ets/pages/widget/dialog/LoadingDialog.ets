import ColorConstants from '../../../constants/ColorConstants'

@CustomDialog
export struct LoadingDialog {
  controller: CustomDialogController
  build() {
    Stack() {
      Column()
        .width(100)
        .height(100)
        .borderRadius(8)
        .backgroundColor(Color.White)

      Image($r('app.media.common_loading'))
        .width(40)
        .height(40)
    }
    .backgroundColor(ColorConstants.COLOR_ALPHA)
    .alignContent(Alignment.Center)
  }
}