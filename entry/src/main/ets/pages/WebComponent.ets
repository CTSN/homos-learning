import webview from '@ohos.web.webview'

/**
 * web
 */
@Component
export struct WebComponent {
  webviewController: WebviewController = new webview.WebviewController

  build() {
    Column(){
      Web({ src: "www.baidu.com", controller: this.webviewController })
    }
  }
}