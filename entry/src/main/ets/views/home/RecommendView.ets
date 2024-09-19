import { RoomItem } from '../../models/home/HomeModel'
import { RecommendDataSource } from '../../models/recommend/RecommendDataSource'
import Api from '../../service/http/Api'
import httpUtil from '../../service/http/HttpUtil'
import { router } from '@kit.ArkUI'
import { RecordList } from '../../models/recommend/RecommendModel'
import RoomCard from './RoomCard'


@Component
export default struct RecommendView {
  @State rDataSource:RecommendDataSource = new RecommendDataSource()

  aboutToAppear(): void {
    this.requestRoomInfoData()
  }

  build() {
    Column({ space: 16 }) {
      this.headerBuilder()
      this.bodyBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_color'))
  }

  //头部组件
  @Builder
  headerBuilder() {
    Row() {
      Text() {
        Span('周边房源 ')
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Span('推荐')
          .fontSize(16)
          .fontColor($r('app.color.primary'))
          .fontWeight(FontWeight.Bold)
      }

      Row({ space: 4 }) {
        Text('更多推荐')
          .textStyle(10, '#666')
          .onClick(this.gotoTargetPage)
        Image($r('app.media.arrow_right'))
          .width(4)
          .height(8)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .height(44)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 15, right: 15 })
    .backgroundColor(Color.White)
  }

  //内容组件
  @Builder
  bodyBuilder() {
    Grid() {
      LazyForEach(this.rDataSource, (item: RoomItem) => {
        GridItem() {
          RoomCard({roomItem: item})
            .width('100%')
            .height(210)
        }
      }, (item: RoomItem) => item.id)
    }
    .width('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(12)
    .padding({ left: 15, right: 15 })
    .backgroundColor($r('app.color.bg_color'))
    .enabled(false)
  }

  //请求数据房源推荐信息
  async requestRoomInfoData() {
    let roomList = await httpUtil.get<RecordList>(Api.roomInfo)
    this.rDataSource.setList(roomList)
  }

  gotoTargetPage() {
    router.pushUrl({url: 'pages/recommend/RecommendPage'})
  }
}

@Extend(Text)
function textStyle(fontSize: number, fontColor: ResourceStr | Color) {
  .fontSize(fontSize)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
}
