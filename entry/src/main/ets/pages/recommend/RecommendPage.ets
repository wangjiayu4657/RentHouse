import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import RoomCard from '../../views/home/RoomCard';
import NavigationBar from '../../components/NavigationBar';
import FilterCriteria from '../../views/recommend/FilterCriteria'
import { RecommendDataSource } from '../../models/recommend/RecommendDataSource';
import { ActivityItem, RecommendModel, recommendParams, RecordItem } from '../../models/recommend/RecommendModel'

@Entry
@Component
struct RecommendPage {
  @StorageProp('statusBarHeight') statusBarHeight: number = 0
  @State dataSource: RecommendDataSource = new RecommendDataSource()
  @State zIdx: number = 0

  aboutToAppear(): void {
    this.requestRecommendData()
  }

  build() {
    Column() {
      //导航
      this.navigationBarBuilder()
      //筛选项
      this.filterItemBuilder()
      //瀑布流
      this.recommendBodyBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }

  @Builder
  navigationBarBuilder() {
    NavigationBar({ title: '房源推荐' })
      .width('100%')
      .height(44 + this.statusBarHeight)
      .padding({ top: this.statusBarHeight })
      .backgroundColor(Color.White)
  }

  //筛选项
  @Builder
  filterItemBuilder() {
    Row() {
      ForEach(['位置', '支付方式', '租金', '排序'], (item: string) => {
        Row({ space: 2 }) {
          Text(item)
            .fontSize(14)
            .fontColor('#333')
            .fontWeight(FontWeight.Medium)

          Image($r('app.media.arrow_down'))
            .width(12)
            .aspectRatio(1)
            .fillColor('#000')
            .objectFit(ImageFit.Contain)
            .padding({ bottom: 4 })
        }
        .onClick(() => {
          this.zIdx = 2
        })
      })
    }
    .width('100%')
    .height(40)
    .padding(15)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  recommendBodyBuilder() {
    Stack() {
      this.filterOptionBuilder()
      this.recommendRoomBuilder()
    }
    .layoutWeight(1)
    .backgroundColor('#F7F7F7')
  }

  @Builder
  filterOptionBuilder() {
    Column() {
      FilterCriteria()
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor('#b3000000')
    .zIndex(this.zIdx)
    .onClick(() => {
      this.zIdx = 0
    })
  }

  @Builder
  recommendRoomBuilder() {
    WaterFlow() {
      LazyForEach(this.dataSource, (item: RecordItem) => {
        FlowItem() {
          this.flowItemBuilder(item)
        }
        .width('100%')
        .height(item.activity ? 320 : 210)
      }, (item: RecordItem) => item.id)
    }
    .width('100%')
    .layoutWeight(1)
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding({ top: 20, left: 15, bottom: 20, right: 15 })
    .backgroundColor('#F7F7F7')
    .zIndex(1)
  }

  //瀑布流 item
  @Builder
  flowItemBuilder(item: RecordItem) {
    RoomCard({ roomItem: item }) {
      if (item.activity) {
        this.topBuilder(item)
      }
    }
  }

  //第一条数数据额外信息
  @Builder
  topBuilder(item: RecordItem) {
    Column() {
      Row({ space: 4 }) {
        Image(item.activity.icon)
          .width(20)
          .aspectRatio(1)
          .objectFit(ImageFit.Contain)

        Text(item.activity.title)
          .fontSize(14)
          .fontColor('#000')
          .fontWeight(FontWeight.Bold)
      }

      Text(this.handlerText(item.activity))
        .fontSize(10)
        .fontColor(item.activity.textColor)
        .fontWeight(FontWeight.Bold)
        .borderRadius(4)
        .margin({ top: 4, bottom: 4 })
        .padding({ top: 4, left: 8, bottom: 4, right: 8 })
        .backgroundColor(item.activity.textBackGroundColor)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  //请求房源推荐数据
  async requestRecommendData() {
    let params: recommendParams = { 'page': 1, 'limit': 10 }
    const rsp = await httpUtil.get<RecommendModel>(Api.recommendInfo, params)
    this.dataSource.setList(rsp.records)
  }

  //处理数据
  handlerText(item: ActivityItem): string {
    // Reflect是供了对对象操作的方法：get、set、delete等
    return Reflect.get(item, '#text')
  }
}

