import http from '@ohos.net.http';
import { LoadingDialog } from '../pages/widget/dialog/LoadingDialog';

export class HttpUtils {

  dialogController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog(),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })

  show () {
    this.dialogController.open()
  }

  dismiss() {
    this.dialogController.close()
  }
  /**
   * post 请求方法
   * @param url 链接
   * @param data  请求参数
   * @param callBack 返回回调
   * @param loadingAction 加载回调
   * @param errorAction 异常回调
   */
  post(url: string, data: any, callBack: (data: any) => void, loadingAction?: () => void, errorAction?: () => void) {
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });
    if (loadingAction) {
      loadingAction()
    }
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        header: {
          'Content-Type': 'application/json'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: data,
        expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
        usingCache: true, // 可选，默认为true
        priority: 1, // 可选，默认为1
        connectTimeout: 100000, // 可选，默认为60000ms
        readTimeout: 100000, // 可选，默认为60000ms
        usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
      }, (err, data) => {
      if (!err) {
        let dataJson = data.result
        callBack(data.result)
        // console.info('Result:' + JSON.stringify(dataJson));
        // console.info('code:' + JSON.stringify(data.responseCode));
        // console.info('header:' + JSON.stringify(data.header));
        // console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
        httpRequest.off('headersReceive');
        httpRequest.destroy();
      } else {
        let errTxt = err
        // console.info('error:' + JSON.stringify(errTxt));
        httpRequest.off('headersReceive');
        httpRequest.destroy();
        if (errorAction) {
          errorAction()
        }
      }
    }
    );
  }
}

export default new HttpUtils()

