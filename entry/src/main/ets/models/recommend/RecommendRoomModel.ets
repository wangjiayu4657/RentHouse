import { RoomItem } from '../home/HomeModel'

//推荐房源数据
export interface RecommendRoomModel {
  records: RecordList //推荐房源的数据源
  total: string //总数据数
}

//推荐房源信息
export interface RecordItem extends RoomItem {
  activity: ActivityItem //首条数据信息
}

export type RecordList = RecordItem[]

export interface TagItem {
  name: string
}

export type TagList = TagItem[]

//推荐房源第一条数据
export interface ActivityItem {
  title: string                   //标题
  textColor: string               //文本颜色
  textBackGroundColor: string     //文本背景颜色
  '#text': string                 //描述信息
  icon: string                    //图标
}

//推荐数据源请求参数
export interface recommendParams {
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


