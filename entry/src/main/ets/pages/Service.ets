import Api from '../service/http/Api';
import ServiceHeader from '../views/service/ServiceHeader';
import httpUtil from '../service/http/HttpUtil'
import ServiceNewbieZone from '../views/service/ServiceNewbieZoneCard';
import { ServiceHomeCard } from '../views/service/ServiceHomeCard';
import { ServiceCalendarCard } from '../views/service/ServiceCalendarCard';
import {
  CleaningServiceInfoList,
  HomeServiceList,
  NewcomerZoneItem,
  ServiceActivityItem,
  ServiceModel,
  VipServiceList
} from '../models/service/ServiceModel';
import ServiceCleanHouse from '../views/service/ServiceCleanHouseCard';

@Styles function cardStyle() {
  .backgroundColor(Color.White)
}

@Preview
@Component
export struct Service {
  @StorageProp('statusBarHeight') statusBarHeight: number = 0
  @State vipServiceList: VipServiceList = []
  @State homeServiceList: HomeServiceList = []
  @State serviceActivity: ServiceActivityItem = { name: '', img: '', title: '', subTitle: '' }
  @State newcomerZoneItem: NewcomerZoneItem = { img: '' }
  @State cleanServiceInfoList: CleaningServiceInfoList = []

  aboutToAppear(): void {
    this.requestServiceInformation()
  }

  build() {
    Column() {
      //头部组件
      ServiceHeader({ vipServiceList: this.vipServiceList })
        .width('100%')
        .height(220 + this.statusBarHeight)

      Scroll() {
        Column({ space: 8 }) {
          //家庭服务组件
          ServiceHomeCard({ homeServiceList: this.homeServiceList })
            .borderRadius(8)
            .backgroundColor(Color.White)

          //服务日历组件
          ServiceCalendarCard({ serviceActivity: this.serviceActivity })
            .borderRadius(8)
            .backgroundColor(Color.White)

          //新人专区组件
          ServiceNewbieZone({ newcomerZoneItem: this.newcomerZoneItem })
            .borderRadius(8)
            .backgroundColor(Color.White)

          //洁净家组件
          ServiceCleanHouse({ cleanServiceInfoList: this.cleanServiceInfoList })
            .borderRadius(8)
            .backgroundColor(Color.White)
        }
        .padding({ bottom: 30 })
        .backgroundColor('#F9F9F9')
        .margin({ left: 12, right: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F9F9')
  }

  //请求获取服务页数据
  async requestServiceInformation() {
    let rsp = await httpUtil.get<ServiceModel>(Api.serviceInfo)
    this.vipServiceList = rsp.vipServiceList
    this.homeServiceList = rsp.homeServiceList
    this.serviceActivity = rsp.serviceActivity
    this.newcomerZoneItem = rsp.newcomerZone
    this.cleanServiceInfoList = rsp.cleaningServiceInfo
  }
}