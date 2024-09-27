import { RoomItem } from '../home/HomeModel'

//推荐房源数据
export interface RecommendRoomModel {
  records: RecordList //推荐房源的数据源
  total: string //总数据数
}

//推荐房源信息
export type RecordList = RecordItem[]
export interface RecordItem extends RoomItem {
  activity: ActivityItem //首条数据信息
}

export type TagList = TagItem[]
export interface TagItem {
  name: string
}

//推荐房源第一条数据
export interface ActivityItem {
  title: string                   //标题
  textColor: string               //文本颜色
  textBackGroundColor: string     //文本背景颜色
  '#text': string                 //描述信息
  icon: string                    //图标
}

//筛选地址回显数据
export class AddressEcho {
  pSelIdx: number
  cSelIdx: number
  dSelIdx: number
  districtName: string

  constructor(pSelIdx:number = 0, cSelIdx:number = 0, dSelIdx:number = 0, districtName:string = '')  {
    this.pSelIdx = pSelIdx
    this.cSelIdx = cSelIdx
    this.dSelIdx = dSelIdx
    this.districtName = districtName
  }
}


//推荐数据源请求参数
export interface IParams {
  page: number
  limit: number
  provinceCode?: string
  cityCode?: string
  districtCode?: string
  minRent?: string
  maxRent?: string
  paymentTyp?: string
  orderBy?: string
  orderType?: string
}

//推荐房源接口请求参数
export class RecommendParams implements IParams {
  page: number
  limit: number
  provinceCode?: string
  cityCode?: string
  districtCode?: string
  minRent?: string
  maxRent?: string
  paymentTyp?: string
  orderBy?: string
  orderType?: string

  constructor(param?:IParams) {
    this.page = param?.page ?? 1
    this.limit = param?.limit ?? 10
    this.provinceCode = param?.provinceCode
    this.cityCode = param?.cityCode
    this.districtCode = param?.districtCode
    this.minRent = param?.minRent
    this.maxRent = param?.maxRent
    this.paymentTyp = param?.paymentTyp
    this.orderBy = param?.orderBy
    this.orderType = param?.orderType
  }

  //重置地址筛选条件
  resetAddressParam() {
    this.provinceCode = '11'
    this.cityCode = ''
    this.districtCode = ''
  }

  //重置支付筛选条件
  resetPayWayParam() {
    this.paymentTyp = ''
  }

  //重置租金筛选条件
  resetRentParam() {
    this.minRent = ''
    this.maxRent = ''
  }

  //重置排序筛选条件
  resetOrderParam() {
    this.orderBy = ''
    this.orderType = ''
  }
}


