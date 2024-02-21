
export default class BaseResponse<Element> {
  code: number
  message: string
  data: Element
}