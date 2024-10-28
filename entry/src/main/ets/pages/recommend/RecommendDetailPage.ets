import { RouterParam } from './RecommendPage';
import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import { DetailParam, RecommendRoomDetailModel } from '../../models/recommend/RecommendRoomDetailModel';
import { HouseDisplay } from '../../views/recommendDetail/HouseDisplay';
import { HouseRentalInformation } from '../../views/recommendDetail/HouseRentalInformation';
import { HouseProtection } from '../../views/recommendDetail/HouseProtection';
import { HouseInformation } from '../../views/recommendDetail/HouseInformation';
import { HouseArticlesConfig } from '../../views/recommendDetail/HouseArticlesConfig';
import { HouseBottomTool } from '../../views/recommendDetail/HouseBottomTool';
import router from '@ohos.router';

@Entry
@Component
struct RecommendDetailPage {
  @StorageProp('statusBarHeight') statusBarHeight: number = 0
  @State detailModel?: RecommendRoomDetailModel = undefined

  aboutToAppear(): void {
    let param = router.getParams() as RouterParam
    const roomId: string = param.id
    this.requestRecommendDetail(roomId)
  }

  build() {
    Column() {
      //导航栏
      this.navBarBuilder()

      Scroll() {
        Column({ space: 30 }) {
          //房屋展示
          HouseDisplay({ picList: this.detailModel?.housePicture })
            .width('100%')
            .height(244)

          //租赁信息
          HouseRentalInformation({ detailModel: this.detailModel })
            .width('100%')

          //房屋信息
          HouseInformation({ rentList: this.detailModel?.rentInfo })
            .width('100%')

          //房屋物品配置
          HouseArticlesConfig({ holdList: this.detailModel?.householdItem })
            .width('100%')

          //租住服务与保障
          HouseProtection({ supportList: this.detailModel?.support })
            .width('100%')
        }
        .padding({ left: 15, right: 15 })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.TopStart)

      //底部工具栏(点赞, 咨询, 立即预定, 去看房)
      HouseBottomTool()
        .width('100%')
        .margin({ bottom: 15 })
    }
    .width('100%')
    .height('100%')
  }

  //导航组件
  @Builder
  navBarBuilder() {
    Row() {
      Image($r('app.media.arrow_back'))
        .width(24)
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          router.back()
        })

      Text(this.detailModel?.houseTitle)
        .fontSize(12)
        .fontColor('#000')
        .fontWeight(FontWeight.Medium)

      Blank()

      Button({ buttonStyle: ButtonStyleMode.NORMAL }) {
        Image($r('app.media.share_btn'))
      }
      .width(20)
      .aspectRatio(1)
    }
    .width('100%')
    .height(44 + this.statusBarHeight)
    .padding({ top: this.statusBarHeight, left: 15, right: 15 })
  }

  //详情数据请求
  async requestRecommendDetail(id: string) {
    let param: DetailParam = { id: id }
    this.detailModel = await httpUtil.get<RecommendRoomDetailModel>(Api.recommendDetail, param)
  }
}