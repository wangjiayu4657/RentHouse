import Api from '../service/http/Api'
import { HomeModel, NavList, PlanList, TileList } from '../models/home/HomeModel'
import httpUtil from '../service/http/HttpUtil'
import { Banner } from '../views/home/Banner';
import UPSearch from '../views/home/UPSearch';
import { BannerDataSource } from '../models/home/BannerDataSource';
import NavView from '../views/home/NavView';
import TileView from '../views/home/TileView';
import PlanView from '../views/home/PlanView';
import RecommendView from '../views/home/RecommendView';
import { NavInfo, ScrollContainer } from '../components/ScrollContainer';


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
    ScrollContainer({
      navParamBuilder: this.searchBuilder,
      bodyParamBuilder: () => {
        this.bodyBuilder()
      }
    })
      .width('100%')
      .height('100%')
  }

  @Builder
  searchBuilder($: NavInfo) {
    UPSearch({ fontColor: $.fontColor})
  }

  @Builder
  bodyBuilder() {
    Column({ space: 20 }) {
      //轮播图组件
      Banner({ bannerSource: this.bannerSource })
        .width('100%')
        .height(212)

      //navView
      NavView({ navList: this.navList })
        .width('100%')
        .height(170)

      Column({ space: 20 }) {
        //tileView
        TileView({ tileList: this.tileList })
          .width('100%')
          .height(100)
          .margin({ top: 10 })

        //计划组件
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
        .height(210 * 4 + 12 * 3 + 44 + 16)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  //请求获取首页数据
  async requestHomeData() {
    let res = await httpUtil.get<HomeModel>(Api.homeInfo)
    this.bannerSource.setList(res.bannerList)
    this.navList = res.navList
    this.tileList = res.tileList
    this.planList = res.planList
    this.imgUrl = res.adPicture
  }
}