
import common from '@ohos.app.ability.common'
import File from '@system.file'

/**
 * 文件工具类
 */
export class FileUtils{


  async  textFunc():Promise<void>{

    let context= getContext() as common.UIAbilityContext

    let filePath:string =context.filesDir+"/test.txt"


  }


  async write(data:string,file:File){


  }

}