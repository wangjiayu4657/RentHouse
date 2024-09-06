import Api from '../service/http/Api'
import { BannerList, HomeModel } from '../models/home/homeModel'
import httpUtil from '../service/http/http'
import { Banner } from '../views/home/Banner';
import UPSearch from '../views/home/UPSearch';


@Component
export struct Home {
  @State bannerList: BannerList = [];

  aboutToAppear(): void {
    this.requestHomeData()
  }

  build() {
    Scroll() {
      Stack() {
        Banner({bannerList: this.bannerList})
        UPSearch()
      }
      .width('100%')
      .backgroundColor(Color.Orange)
      .alignContent(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP])
  }

  //请求获取首页数据
  async requestHomeData() {
    let res = await httpUtil.get<HomeModel>(Api.homeInfo)
    this.bannerList = res.bannerList
    console.log('res == ', JSON.stringify(res))
  }
}