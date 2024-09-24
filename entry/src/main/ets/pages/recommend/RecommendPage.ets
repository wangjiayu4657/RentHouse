import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import RoomCard from '../../views/home/RoomCard';
import NavigationBar from '../../components/NavigationBar';
import FilterCriteria from '../../views/recommend/FilterCriteria'
import { RecommendDataSource } from '../../models/recommend/RecommendDataSource';
import { ActivityItem, RecommendRoomModel, recommendParams, RecordItem } from '../../models/recommend/RecommendRoomModel'
import { AddressParam } from '../../models/recommend/RecommendAddressModel';


@Entry
@Component
struct RecommendPage {
  @StorageProp('statusBarHeight') statusBarHeight: number = 0  //状态栏高度
  @State dataSource: RecommendDataSource = new RecommendDataSource()  //懒加载数据源
  @State page: number = 1       //分页查询页码
  @State total: number = 0      //总数据

  @State isShowRefresh: boolean = true  //是否显示刷新
  @State isNoData:boolean = false       //是否为空数据

  @State isShowAddressFilter:boolean = false  //是否显示地址筛选条件
  @State pSelIdx:number = 0  //选中的省份
  @State cSelIdx:number = 0  //选中的城市
  @State dSelIdx:number = 0  //选中的县区


  aboutToAppear(): void {
    this.requestRecommendData(this.page)
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
          if(this.isShowAddressFilter) return
          this.isShowAddressFilter = true
        })
      })
    }
    .width('100%')
    .height(40)
    .padding({left: 15, right: 15})
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  recommendBodyBuilder() {
    Stack() {
      this.recommendRoomBuilder()

      if (this.isNoData) {
        this.emptyBuilder()
      }

      if(this.isShowAddressFilter) {
        this.filterOptionBuilder()
      }
    }
    .layoutWeight(1)
    .backgroundColor('#F7F7F7')
  }

  @Builder
  filterOptionBuilder() {
    Column() {
      FilterCriteria({
        pSelIdx: this.pSelIdx,
        cSelIdx: this.cSelIdx,
        dSelIdx: this.dSelIdx,
        onEmptyClick: () => {
          this.isShowAddressFilter = false
        },
        onResetClick: () => {
          this.pSelIdx = 0
          this.cSelIdx = 0
          this.dSelIdx = 0
          this.isShowAddressFilter = false
          this.requestRecommendData(this.page, undefined)
        },
        onCheckClick: (address:AddressParam) => {
          // console.log('address -- ', JSON.stringify(address))
          this.pSelIdx = address.pSelIdx ?? 0
          this.cSelIdx = address.cSelIdx ?? 0
          this.dSelIdx = address.dSelIdx ?? 0
          this.isShowAddressFilter = false
          this.requestRecommendData(this.page, address)
        }
      })
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor('#b3000000')
    .onClick(() => {
      this.isShowAddressFilter = true
    })
  }

  @Builder
  recommendRoomBuilder() {
    WaterFlow({ footer: this.waterFlowFooterBuilder() }) {
      LazyForEach(this.dataSource, (item: RecordItem, idx:number) => {
        FlowItem() {
          this.flowItemBuilder(item)
        }
        .width('100%')
        .padding({top: (idx == 0 || idx == 1) ? 15 : 10})
        .height(item.activity ? 335 : 220)
      }, (item: RecordItem) => item.id)
    }
    .width('100%')
    .height('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .backgroundColor('#F7F7F7')
    .padding({left: 15, right: 15})
    .onReachEnd(() => {
      this.page++
      this.requestRecommendData(this.page)
    })
  }

  @Builder
  waterFlowFooterBuilder() {
    if(!this.isNoData) {
      if (this.isShowRefresh) {
        Row({ space: 10 }) {
          Refresh({ refreshing: true })
          Text('加载中...').fontColor('#999999').padding({ top: 4 })
        }
        .width('100%')
        .padding(15)
        .backgroundColor('#F7F7F7')
        .justifyContent(FlexAlign.Center)
      } else {
        Text('没有更多数据了~')
          .width('100%')
          .padding(15)
          .textAlign(TextAlign.Center)
          .backgroundColor('#F7F7F7')
      }
    }
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

  //空数据组件
  @Builder
  emptyBuilder() {
    Column({space: 15}) {
      Image($r('app.media.recommend_no_data'))
        .width(180)
        .fillColor('#999')

      Text('暂无数据')
        .fontSize(16)
        .fontColor('#666')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  //请求房源推荐数据
  async requestRecommendData(page: number, address?:AddressParam) {
    if(this.dataSource.totalCount() != 0 && this.dataSource.totalCount() >= this.total) {
      this.isShowRefresh = false
      return
    }

    let params: recommendParams = {
      page: page,
      limit: 10,
      provinceCode: address?.provinceCode,
      cityCode: address?.cityCode,
      districtCode: address?.districtCode,
    }

    const rsp = await httpUtil.get<RecommendRoomModel>(Api.recommendInfo, params)
    if(page == 1) { //刷新
      this.dataSource.setList(rsp.records)
    } else {        //翻页
      this.dataSource.pushList(rsp.records)
    }

    this.total = Number(rsp.total)
    this.isNoData = rsp.records.length == 0
  }

  //处理数据
  handlerText(item: ActivityItem): string {
    // Reflect是供了对对象操作的方法：get、set、delete等
    return Reflect.get(item, '#text')
  }
}

