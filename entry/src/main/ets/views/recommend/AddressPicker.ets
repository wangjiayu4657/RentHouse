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
export default struct AddressPicker {
  @State provinceList: ProvinceList = []
  @State cityList: CityList = []
  @State districtList: DistrictList = []

  @Prop addressParam:AddressParam

  //点击空白
  onEmptyClick:VoidCallback = () => {}
  //重置
  onResetClick:VoidCallback = () => {}
  //查看房源
  onCheckClick:(search:AddressParam) => void = () => {}

  aboutToAppear(): void {
    this.requestAddressData(AddressType.province)
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
      Row({space: 20}) {
        Button('重置')
          .btnStyle('#666', '#F0F0F0')
          .layoutWeight(1)
          .onClick(() => {
            this.onResetClick()
          })

        Button('查看房源')
          .btnStyle('#fff', '#67C0A8')
          .layoutWeight(2)
          .onClick(() => {
            this.onCheckClick(this.addressParam)
          })
      }
      .width('100%')
      .padding(15)
      .backgroundColor('#F7F7F7')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .onClick(() => {
      this.onEmptyClick()
    })
  }

  @Builder
  addressList<T extends ProvinceItem>($: AddressInfo<T>) {
    Column() {
      //列表
      List() {
        ForEach($.list, (item: T, idx:number) => {
          ListItem() {
            Text(item.name)
              .fontSize(15)
              .fontColor(this.handlerTextColor($.type, idx))
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height(44)
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
    .padding({ top: 10})
  }

  //处理选中/未选中时的文本颜色
  handlerTextColor(type:AddressType, idx:number): ResourceColor {
    if(type == AddressType.province) {
      return this.addressParam.pSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else if(type == AddressType.city) {
      return this.addressParam.cSelIdx == idx ? $r('app.color.primary') : Color.Black
    } else {
      return this.addressParam.dSelIdx == idx ? $r('app.color.primary') : Color.Black
    }
  }

  //处理选中的地址
  handlerDidSelectedAddress<T>($: AddressInfo<T>, idx:number) {
    if ($.type == AddressType.province) {
      this.addressParam.pSelIdx = idx
      this.addressParam.cSelIdx = 0
      this.addressParam.dSelIdx = 0
      this.requestAddressData($.type)
    } else if ($.type == AddressType.city) {
      this.addressParam.cSelIdx = idx
      this.addressParam.dSelIdx = 0
      this.requestAddressData($.type)
    } else {
      this.addressParam.dSelIdx = idx
    }
  }

  //请求筛选位置数据
  async requestAddressData(type: AddressType) {
    //获取省份数据
    if (this.provinceList.length == 0) {
      this.provinceList = await httpUtil.get<ProvinceList>(Api.provinceInfo)
    }

    //获取市数据
    if(type == AddressType.province) {
      const provinceCode = this.provinceList[this.addressParam.pSelIdx ?? 0].code ?? ''
      const cityParam: CityItem = { 'provinceCode': provinceCode }
      this.cityList = await httpUtil.get<CityList>(Api.cityInfo, cityParam)
    }

    //获取区域数据
    const cityCode = this.cityList[this.addressParam.cSelIdx ?? 0].code ?? ''
    const districtParam: DistrictItem = { 'cityCode': cityCode }
    this.districtList = await httpUtil.get<DistrictList>(Api.districtInfo, districtParam)

    //获取选中的地址
    this.addressParam.provinceCode = this.provinceList[this.addressParam.pSelIdx ?? 0].code ?? ''
    this.addressParam.cityCode = this.cityList[this.addressParam.cSelIdx ?? 0].code ?? ''
    this.addressParam.districtCode = this.districtList[this.addressParam.dSelIdx ?? 0].code ?? ''
  }
}

@Extend(Button) function btnStyle(fontColor:ResourceColor, bgColor:ResourceColor) {
  .type(ButtonType.Normal)
  .fontSize(14)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
  .borderRadius(4)
  .backgroundColor(bgColor)
}
