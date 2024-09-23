import httpUtil from '../../service/http/HttpUtil'
import {
  AddressList,
  AddressParam,
  AddressType,
  CityItem,
  CityList,
  DistrictItem,
  DistrictList,
  ProvinceItem,
  ProvinceList
} from '../../models/recommend/FilterAddressModel'
import Api from '../../service/http/Api'


interface ColorData {
  textColor: ResourceColor
  bgColor: ResourceColor
}


@Component
export default struct FilterCriteria {
  @State provinceList: ProvinceList = []
  @State cityList: CityList = []
  @State districtList: DistrictList = []

  // callBack: (param?: AddressParam) => void = (param?: AddressParam) => { }
  callBack: () => void = () => {

  }

  aboutToAppear(): void {
    this.requestAddressData()
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
      this.addressList<ProvinceItem>({
        list: this.cityList,
        type: AddressType.city,
        color: '#EBEBEB'
      })

      //县区
      this.addressList<ProvinceItem>({
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
  addressList<T extends ProvinceItem>($: AddressList<T>) {
    Column() {
      List() {
        ForEach($.list, (item: T, idx:number) => {
          ListItem() {
            Text(item.name)
              .fontSize(15)
              .fontColor($r('app.color.primary'))
              .fontWeight(FontWeight.Medium)
          }
          .padding({ top: 10, bottom: 10 })
          .onClick(() => {
            if ($.type == AddressType.province) {
              this.requestAddressData(item.code, undefined)
            } else if($.type == AddressType.city) {
              this.requestAddressData(undefined, item.code)
            }
            this.callBack ? this.callBack() : null
          })
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


  @Builder
  addressPickerBuilder() {
    Column() {
      TextPicker() {

      }
    }
    .height('100%')
    .layoutWeight(1)

    .padding({ top: 10, left: 15, bottom: 10, right: 15 })
  }

  handlerBgColor<T>(item:AddressList<T>, isProvinceSel:boolean, isCitySel: boolean, isDistrictSel:boolean) {
    if(item.type == AddressType.province) {
      return isProvinceSel ? $r('app.color.primary') : Color.Black
    } else if(item.type == AddressType.city) {
      return isCitySel ? $r('app.color.primary') : Color.Black
    } else {
      return isDistrictSel ? $r('app.color.primary') : Color.Black
    }
  }

  //请求筛选位置数据
  async requestAddressData(provinceCode?: string, cityCode?: string) {
    let tempProvinceCode = provinceCode ? provinceCode : ''
    if (this.provinceList.length == 0) {
      //获取省份数据
      const provinceRsp = await httpUtil.get<ProvinceList>(Api.provinceInfo)
      tempProvinceCode = provinceRsp[0].code ?? ''
      this.provinceList = provinceRsp
    }

    //获取市数据
    let cityParam: CityItem = { 'provinceCode': tempProvinceCode }
    const cityRsp = await httpUtil.get<CityList>(Api.cityInfo, cityParam)
    const tempCityCode = cityCode ? cityCode : cityRsp[0].code ?? ''
    this.cityList = cityRsp

    //获取区数据
    let districtParam: DistrictItem = { 'cityCode': tempCityCode }
    const districtRsp = await httpUtil.get<DistrictList>(Api.districtInfo, districtParam)
    this.districtList = districtRsp
  }
}
