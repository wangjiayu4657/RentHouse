import Api from '../service/http/Api'
import { HomeModel, NavList, PlanList, TileList } from '../models/home/HomeModel'
import httpUtil from '../service/http/http'
import { Banner } from '../views/home/Banner';
import UPSearch from '../views/home/UPSearch';
import { BannerDataSource } from '../models/home/BannerDataSource';
import NavView from '../views/home/NavView';
import TileView from '../views/home/TileView';
import PlanView from '../views/home/PlanView';
import RecommendView from '../views/home/RecommendView';


@Component
export struct Home {
  @State bannerSource: BannerDataSource = new BannerDataSource()
  @State navList: NavList = []
  @State tileList: TileList = []
  @State planList: PlanList = []
  @State imgUrl: string = ''

  aboutToAppear(): void {
    this.requestHomeData()
  }

  build() {
    // Stack() {
      //滚动画布
      this.scrollBuilder()
      //搜索栏
    //   UPSearch()
    // }
    // .width('100%')
    // .height('100%')
    // .alignContent(Alignment.Top)
  }

  @Builder
  scrollBuilder() {
    //滚动画布
    Scroll() {
      Column({ space: 20 }) {
        //banner
        Banner({ bannerSource: this.bannerSource })
          .width('100%')
          .height(212)

        Column({ space: 20 }) {
          //navView
          NavView({ navList: this.navList })
            .width('100%')
            .height(170)

          //tileView
          TileView({ tileList: this.tileList })
            .width('100%')
            .height(80)
            .margin({ top: 10 })

          //planView
          PlanView({ planList: this.planList })
            .width('100%')
            .height(60)

          //广告图标
          Image(this.imgUrl)
            .width('100%')
            .height(60)
            .shadow({
              offsetX: 0,
              offsetY: 0,
              radius: 8,
              color: $r('app.color.shadowColor'),
            })
        }
        .width('100%')
        .padding({ left: 15, right: 15 })
        .visibility(Visibility.Visible)

        //推荐房源
        RecommendView()
          .width('100%')
          .backgroundColor($r('app.color.bg_color'))
          .height(210 * 4 + 8 * 3 + 44 + 16 + 60)
      }
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
    .backgroundColor(Color.Orange)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .backgroundImageSize(ImageSize.Auto)
    .visibility(Visibility.Visible)
  }

  //请求获取首页数据
  async requestHomeData() {
    let res = await httpUtil.get<HomeModel>(Api.homeInfo)
    this.bannerSource.setList(res.bannerList)
    this.navList = res.navList
    this.tileList = res.tileList
    this.planList = res.planList
    this.imgUrl = res.adPicture
    console.log('res == ', JSON.stringify(res.planList))
  }
}