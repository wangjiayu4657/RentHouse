export interface ServiceModel {
  //vip 信息
  vipServiceList: VipServiceList
  //家庭服务
  homeServiceList: HomeServiceList
  //服务日历
  serviceActivity: ServiceActivityItem
  //新人专区
  newcomerZone: NewcomerZoneItem
  //洁净家服务选项
  cleaningServiceInfo: CleaningServiceInfoList
}


//vip 信息
export interface VipServiceItem {
  name: string
  content: number
}
export type VipServiceList = VipServiceItem[]

//家庭服务选项
export interface HomeServiceItem {
  icon: string
  title: string
}
export type HomeServiceList = HomeServiceItem[]

//服务日历选项
export interface ServiceActivityItem {
  name: string
  img: string
  title: string
  subTitle: string
}

//新人专区
export interface NewcomerZoneItem {
  img: string
}

//清洁选项
export interface CleaningServiceInfoItem {
  img: string
  title: string
  subTitle: string
  originalPrice: string
  priceAfterDiscounts: string
}
export type CleaningServiceInfoList = CleaningServiceInfoItem[]
