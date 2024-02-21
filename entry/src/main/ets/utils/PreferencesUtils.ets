import dataPreferences from '@ohos.data.preferences';

/**
 * 定义首选项接口对象
 */
let preference: dataPreferences.Preferences
let context = getContext(this);
let KEY_PREFERENCES = "myPreference"

/**
 * 首选项存储少量数据
 */
export class PreferencesUtils {

  /**
   * @returns 获取首选项实例
   */
  static async getPreferences(): Promise<dataPreferences.Preferences> {
    return new Promise<dataPreferences.Preferences>((resolved, rejected) => {
      dataPreferences.getPreferences(context, KEY_PREFERENCES)
        .then((res) => {
          resolved(res);
        })
        .catch(reason => {
          rejected("hello,world");
        })
    });
  }


  /**
   * 加入数据
   * @param key
   * @param value
   */
  static async putValue(key: string, value: unknown) {
    if (!preference) {
      await this.getPreferences();
    }
    try {
      if (typeof value === "number") {
        await preference.put(key, value);
      }
      if (typeof value === "string") {
        await preference.put(key, value);
      }
      if (typeof value === "boolean") {
        await preference.put(key, value);
      }
      if (typeof value === "object") {
        if (Array.isArray(value)) {
          await preference.put(key, value);
        } else {
          await preference.put(key, JSON.stringify(value));
        }
      }
    } catch (err) {
      console.error(`Failed to put value. Code is ${err.code},message:${err.message}`);
    }
    // Store the Preference instance in the preference persistence file
    await preference.flush();
  }

  /**
   * 获取数据
   * @param key
   * @returns 结果
   */
  static async getString(key: string) {
    let value: unknown
    if (!preference) {
      await this.getPreferences()
    }
    try {
      value = await preference.get(key, undefined).then()
    } catch (err) {
      console.error(`Failed to get value. Code is ${err.code},message:${err.message}`);
    }
    return value
  }


  /**
   * 删除key对应的数据
   * @param key
   */
  static async delete(key:string){
    if (!preference) {
      await this.getPreferences();
    }
    try {
      await preference.delete(key).then();
    } catch (err) {
      console.error(`Failed to delete value. Code is ${err.code},message:${err.message}`);
    }
  }


  /**
   * @returns 获取所有key值
   */
  static async getAll(){
    let value :unknown
    if (!preference) {
      await this.getPreferences()
    }
    try {
      value = preference.getAll().then()
    }catch (err){
      console.error(`Failed to get All. Code is ${err.code},message:${err.message}`);
    }
    return value
  }
}