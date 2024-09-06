
//首页数据模型
export interface HomeModel {
  bannerList: BannerList,
  navList: NavList,
  tileList: TileList,
  planList: PlanList,
  adPicture: string
}

//轮播图数据模型
export interface BannerItem {
  id: number
  name: string
  imageURL: string
}
export type BannerList = BannerItem[]

//导航列表数据模型
export interface NavItem {
  id: number
  title: string
  imageURL: string
}
export type NavList = NavItem[]

//瓷片列表数据模型
export interface TileItem {
  id: number
  imageURL: string
  title: string
  sub_title: string
}
export type TileList = TileItem[]

//计划列表数据模型
export interface PlanItem {
  id: number
  imageURL: string
}
export type PlanList = PlanItem[]