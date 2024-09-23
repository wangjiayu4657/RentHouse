
export default class Api {
  //首页信息接口
  static readonly homeInfo:string = '/home/info'

  //首页房源信息接口
  static readonly roomInfo:string = '/house/nearbyHouses'

  //服务页信息接口
  static readonly serviceInfo:string = '/service/info'

  //推荐房源信息接口
  static readonly recommendInfo:string = '/house/search'

  //推荐房源省份位置信息接口
  static readonly provinceInfo:string = '/province'
  //推荐房源市位置信息接口
  static readonly cityInfo:string = '/city'
  //推荐房源区位置信息接口
  static readonly districtInfo:string = '/area'
}
