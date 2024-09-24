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

  @Prop pSelIdx: number = 0  //选中的省份
  @Prop cSelIdx: number = 0  //选中的城市
  @Prop dSelIdx: number = 0  //选中的县区

  addressParam:AddressParam = {provinceCode: '', cityCode: '', districtCode: ''}

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
        this.addressPicker<ProvinceItem>({
          list: this.provinceList,
          type: AddressType.province,
          color: '#F7F7F7'
        })

        //城市
        this.addressPicker<CityItem>({
          list: this.cityList,
          type: AddressType.city,
          color: '#EBEBEB'
        })

        //县区
        this.addressPicker<DistrictItem>({
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
  addressPicker<T extends ProvinceItem>($: AddressInfo<T>) {
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

    //获取选中的地址
    this.addressParam.pSelIdx = this.pSelIdx
    this.addressParam.provinceCode = this.provinceList[this.pSelIdx].code ?? ''

    this.addressParam.cSelIdx = this.cSelIdx
    this.addressParam.cityCode = this.cityList[this.cSelIdx].code ?? ''

    this.addressParam.dSelIdx = this.dSelIdx
    this.addressParam.districtCode = this.districtList[this.dSelIdx].code ?? ''
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
