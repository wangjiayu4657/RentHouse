import Api from '../service/http/Api'
import { BannerList, HomeModel } from '../models/home/HomeModel'
import httpUtil from '../service/http/http'
import { Banner } from '../views/home/Banner';
import UPSearch from '../views/home/UPSearch';
import { BannerDataSource } from '../models/home/BannerDataSource';


@Component
export struct Home {
  @State bannerSource: BannerDataSource = new BannerDataSource()

  aboutToAppear(): void {
    this.requestHomeData()
  }

  build() {
    Scroll() {
      Stack() {
        Banner({bannerSource: this.bannerSource})
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
    this.bannerSource.setList(res.bannerList)
    console.log('res == ', JSON.stringify(res))
  }
}