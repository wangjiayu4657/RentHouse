import Api from '../../service/http/Api'
import httpUtil from '../../service/http/HttpUtil'
import FooterOperation from './FooterOperation'
import { AddressEcho, RecommendParams } from '../../models/recommend/RecommendRoomModel'
import { emitter } from '@kit.BasicServicesKit'
import { MockSetup } from '@ohos/hamock'
import {
  AddressInfo,
  AddressType,
  CityItem,
  CityList,
  DistrictItem,
  DistrictList,
  ProvinceItem,
  ProvinceList
} from '../../models/recommend/RecommendAddressModel'


//筛选条件 - 地址
@Component
export default struct AddressPicker {
  @State provinceList: ProvinceList = [] //省份数据源
  @State cityList: CityList = [] //城市数据源
  @State districtList: DistrictList = [] //县区数据源
  @Prop addressEcho: AddressEcho //筛选条件
  @Link addressParam: RecommendParams //地址查询条件

  @MockSetup
  mock() {
    //本地 mock 的数据, 防止预览器中报数据未初始化, 模拟器中可以不用写
    this.addressEcho = new AddressEcho();
  }

  aboutToAppear(): void {
    this.requestAddressData(AddressType.province)

    //重置条件
    emitter.on('resetFilterCriteria', () => {
      emitter.emit('resetFilter')
    })

    //查看房源
    emitter.on('searchRecommendRoom', () => {
      if (this.addressEcho.districtName.length === 0) {
        const districtItem:DistrictItem = this.districtList[this.addressEcho.dSelIdx]
        if(districtItem) {
          this.addressEcho.districtName = districtItem.name ?? ''  //this.districtList[this.addressEcho.dSelIdx].name
        }
      }

      let addressEcho: AddressEcho = new AddressEcho(
        this.addressEcho.pSelIdx,
        this.addressEcho.cSelIdx,
        this.addressEcho.dSelIdx,
        this.addressEcho.districtName
      )

      emitter.emit('searchFilter', { data: addressEcho })
    })
  }

  aboutToDisappear(): void {
    emitter.off('resetFilterCriteria')
    emitter.off('searchRecommendRoom')
  }

  build() {
    Column() {
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

      //操作按钮
      FooterOperation()
        .width('100%')
        .padding(15)
        .backgroundColor('#F7F7F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#b3000000')
    .onClick(() => emitter.emit('emptyClick'))
  }

  @Builder
  addressList<T extends ProvinceItem>($: AddressInfo<T>) {
    Column() {
      //列表
      List() {
        ForEach($.list, (item: T, idx: number) => {
          ListItem() {
            Text(item.name)
              .fontSize(15)
              .fontColor(this.handlerTextColor($.type, idx))
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height(44)
          .onClick(() => this.handlerDidSelectedAddress($, item, idx))
        }, (item: T) => item.code)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .height('100%')
    .layoutWeight(1)
    .backgroundColor($.color)
    .padding({ top: 10 })
  }

  //处理选中/未选中时的文本颜色
  handlerTextColor(type: AddressType, idx: number): ResourceColor {
    if (type == AddressType.province) {
      return this.addressEcho.pSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else if (type == AddressType.city) {
      return this.addressEcho.cSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else {
      return this.addressEcho.dSelIdx == idx ? $r('app.color.primary') : Color.Black
    }
  }

  //处理选中的地址
  handlerDidSelectedAddress<T extends ProvinceItem>($: AddressInfo<T>, item: T, idx: number) {
    if ($.type == AddressType.province) {
      this.addressEcho.pSelIdx = idx
      this.addressEcho.cSelIdx = 0
      this.addressEcho.dSelIdx = 0
      this.requestAddressData($.type)
    } else if ($.type == AddressType.city) {
      this.addressEcho.cSelIdx = idx
      this.addressEcho.dSelIdx = 0
      this.requestAddressData($.type)
    } else {
      this.addressEcho.dSelIdx = idx
      this.addressEcho.districtName = item.name ?? ''
    }
  }

  //请求筛选位置数据
  async requestAddressData(type: AddressType) {
    this.addressEcho.districtName = '' //重置区县名称

    //获取省份数据
    if (this.provinceList.length == 0) {
      this.provinceList = await httpUtil.get<ProvinceList>(Api.provinceInfo)
    }

    console.log('addressEcho == ', JSON.stringify(this.addressEcho))
    //获取市数据
    if (type == AddressType.province) {
      const provinceCode = this.provinceList[this.addressEcho.pSelIdx].code ?? ''
      const cityParam: CityItem = { 'provinceCode': provinceCode }
      this.cityList = await httpUtil.get<CityList>(Api.cityInfo, cityParam)
    }

    //获取区域数据
    const cityCode = this.cityList[this.addressEcho.cSelIdx].code ?? ''
    const districtParam: DistrictItem = { 'cityCode': cityCode }
    this.districtList = await httpUtil.get<DistrictList>(Api.districtInfo, districtParam)

    //获取选中的地址
    this.addressParam.provinceCode = this.provinceList[this.addressEcho.pSelIdx].code ?? ''
    this.addressParam.cityCode = this.cityList[this.addressEcho.cSelIdx].code ?? ''
    this.addressParam.districtCode = this.districtList[this.addressEcho.dSelIdx].code ?? ''
  }
}
