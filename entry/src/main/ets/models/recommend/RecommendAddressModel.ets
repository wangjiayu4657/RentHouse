
//推荐房源搜索地址数据
export interface RecommendAddressModel {
  provinceList: ProvinceList
  cityList: CityList
  districtList: DistrictList
}

//省份
export interface ProvinceItem {
  code?: string  //省代码
  name?: string  //省/市/区名称
}
export type ProvinceList = ProvinceItem[]

//城市
export interface CityItem extends ProvinceItem {
  provinceCode?: string  //省代码
}
export type CityList = CityItem[]

//县区
export interface DistrictItem extends CityItem{
  cityCode: string  //市代码
}
export type DistrictList = DistrictItem[]

export interface AddressParam {
  provinceCode:string
  cityCode:string
  districtCode:string
  pSelIdx?:number
  cSelIdx?:number
  dSelIdx?:number
}

//地址类型
export enum AddressType {
  province, //省
  city,     //市
  district  //区
}

export interface AddressInfo<T> {
  list: T[]
  type: AddressType
  color: ResourceColor
}