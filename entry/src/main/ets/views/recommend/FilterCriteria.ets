import httpUtil from '../../service/http/HttpUtil'
import {
  AddressInfo,
  AddressParam,
  AddressType,
  CityItem,
  CityList,
  DistrictItem,
  DistrictList,
  ProvinceItem,
  ProvinceList
} from '../../models/recommend/RecommendAddressModel'
import Api from '../../service/http/Api'


@Component
export default struct FilterCriteria {
  @State provinceList: ProvinceList = []
  @State cityList: CityList = []
  @State districtList: DistrictList = []

  @State pSelIdx: number = 0
  @State cSelIdx: number = 0
  @State dSelIdx: number = 0

  callBack: (param?: AddressParam) => void = (param?: AddressParam) => { }

  aboutToAppear(): void {
    this.requestAddressData(AddressType.province)
  }

  build() {
    Row() {
      //省份
      this.addressList<ProvinceItem>({
        list: this.provinceList,
        type: AddressType.province,
        color: '#F7F7F7'
      })

      //城市
      this.addressList<CityItem>({
        list: this.cityList,
        type: AddressType.city,
        color: '#EBEBEB'
      })

      //县区
      this.addressList<DistrictItem>({
        list: this.districtList,
        type: AddressType.district,
        color: '#E6E6E6'
      })
    }
    .width('100%')
    .height(330)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  addressList<T extends ProvinceItem>($: AddressInfo<T>) {
    Column() {
      List() {
        ForEach($.list, (item: T, idx:number) => {
          ListItem() {
            Text(item.name)
              .fontSize(15)
              .fontColor(this.handlerTextColor($.type, idx))
              .fontWeight(FontWeight.Medium)
          }
          .padding({ top: 10, bottom: 10 })
          .onClick(() => this.handlerDidSelectedAddress($, idx))
        }, (item: T) => item.code)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .height('100%')
    .layoutWeight(1)
    .backgroundColor($.color)
    .padding({ top: 10, left: 15, bottom: 10, right: 15 })
  }

  //处理选中/未选中时的文本颜色
  handlerTextColor(type:AddressType, idx:number): ResourceColor {
    if(type == AddressType.province) {
      return this.pSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else if(type == AddressType.city) {
      return this.cSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else {
      return this.dSelIdx == idx ? $r('app.color.primary') : Color.Black
    }
  }

  //处理选中的地址
  handlerDidSelectedAddress<T>($: AddressInfo<T>, idx:number) {
    if ($.type == AddressType.province) {
      this.pSelIdx = idx
      this.cSelIdx = 0
      this.dSelIdx = 0
      this.requestAddressData($.type)
    } else if ($.type == AddressType.city) {
      this.cSelIdx = idx
      this.dSelIdx = 0
      this.requestAddressData($.type)
    } else {
      this.dSelIdx = idx
    }

    this.callBack ? this.callBack() : null
  }

  //请求筛选位置数据
  async requestAddressData(type: AddressType) {
    //获取省份数据
    if (this.provinceList.length == 0) {
      this.provinceList = await httpUtil.get<ProvinceList>(Api.provinceInfo)
    }

    //获取市数据
    if(type == AddressType.province) {
      const provinceCode = this.provinceList[this.pSelIdx].code ?? ''
      const cityParam: CityItem = { 'provinceCode': provinceCode }
      this.cityList = await httpUtil.get<CityList>(Api.cityInfo, cityParam)
    }

    //获取区域数据
    const cityCode = this.cityList[this.cSelIdx].code ?? ''
    const districtParam: DistrictItem = { 'cityCode': cityCode }
    this.districtList = await httpUtil.get<DistrictList>(Api.districtInfo, districtParam)
  }
}
