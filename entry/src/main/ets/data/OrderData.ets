/**
 *
 */
export class OrderData {
  status: number

  title: string

  detail: string

  startDate: string

  endDate: string

  constructor(status: number, title: string, detail: string, startDate: string, endDate: string) {
    this.status = status
    this.title = title
    this.detail = detail
    this.startDate = startDate
    this.endDate = endDate
  }
}