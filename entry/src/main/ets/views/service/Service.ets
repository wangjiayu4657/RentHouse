import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import ServiceTabBar from './ServiceTabBar';
import ServiceHeader from './ServiceHeader';
import { ServiceHomeCard } from './ServiceHomeCard';
import { ServiceCalendarCard } from './ServiceCalendarCard';
import {
  CleaningServiceInfoList,
  HomeServiceList,
  NewcomerZoneItem,
  ServiceActivityItem,
  ServiceModel,
  VipServiceList
} from '../../models/service/ServiceModel';


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

          ServiceTabBar({newcomerZoneItem: this.newcomerZoneItem, cleanServiceInfoList: this.cleanServiceInfoList})
            .margin({top: 10})

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