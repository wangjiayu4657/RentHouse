import { TagList } from './RecommendRoomModel'

export interface RecommendRoomDetailModel {
  houseTitle: string                //标题
  address: string                   //地址
  rentPriceUnit: string             //租金单位
  housePicture: HousePictureList    //房间图片
  tags: TagList                     //优点
  rentPriceUnitListing: string      //租金价格
  distanceInfo: string
  rentTerm: RentTermItem            //租赁详情
  metaInfo: MetaInfoList            //房屋详情
  id: string                        //id
  rentArea: string                  //租赁面积
  discounts: DiscountsList          //折扣信息
  householdItem: HouseholdList      //物品配置
  support: SupportList              //服务与保障
  rentInfo: RentInfoList            //房屋已租信息
}


export type HousePictureList = HousePictureItem[]

@Observed
export class HousePictureItem {
  spaceName: string
  picList: string[]

  constructor(spaceName: string, picList: string[]) {
    this.spaceName = spaceName
    this.picList = picList
  }
}

export interface RentTermItem {
  checkInTime: string       //租期最长1年10个月
  term: string              //随时入住
  kitchen: string           //厨房
  lift: string              //电梯
  seeTime: string           //可随时看房
  year: string              //建成年份
  renovation: string        //装修情况
  grounding: string         //上架情况
  heating: string           //供暖
  green: string             //绿化
  protection: string        //环保
  house: string             //小区
}

type MetaInfoList = MetaInfoItem[]
export interface MetaInfoItem {
  name: string
  desc: string
}

type DiscountsList = DiscountsItem[]
export interface DiscountsItem {
  tagTxtBgAroundColor: string   //背景色
  image: string                 //图片
  txt: string                   //万份暖冬补贴，最高2800元
  tagTxt: string                //最高优惠2800元
  tagTxtColor: string           //字体颜色
}


export type HouseholdList = HouseholdItem[]
export interface HouseholdItem {
  name: string          //房间名称
  itemList: ItemList    //房间物品
}

type ItemList = RoomItem[]
export interface RoomItem {
  icon: string      //物品图片
  value: string     //物品描述
}

//服务保障项目
export type SupportList = SupportItem[]
export interface SupportItem {
  image: string     //图标
  title: string     //保障项目名称
  subTitle: string  //描述
}

//房屋已租信息
export type RentInfoList = RentInfoItem[]
export interface RentInfoItem {
  image: string     //房屋租客头像
  title: string     //02卧·已租5个月
  userTag: string   //男 | 天蝎座 | 天蝎座
}

//详情数据请求接口参数
export interface DetailParam {
  id: string
}