
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

//房间优势描述信息
export interface TagItem {
  name: string
}
export type TagList = TagItem[]

//房间信息
export interface RoomItem {
  id: string               //id
  housePicture: string     //房间图片
  tags: TagList            //房间优势描述信息
  houseTitle: string       //房间出租方式描述标题
  address: string          //房间地址
  rentPriceUnit: string    //房间价格单位
  rentPriceListing: string //房间价格
  rentArea: string         //房间面积
}
export type RoomList = RoomItem[]