import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import RoomCard from '../../views/home/RoomCard';
import NavigationBar from '../../components/NavigationBar';
import AddressPicker from '../../views/recommend/AddressPicker'
import { RecommendDataSource } from '../../models/recommend/RecommendDataSource';
import {
  ActivityItem,
  RecommendParams,
  RecommendRoomModel,
  RecordItem
} from '../../models/recommend/RecommendRoomModel'



enum FilterType {
  address, //地址
  pay,     //支付方式
  rent,    //租金
  sort     //排序
}


@Entry
@Component
struct RecommendPage {
  @StorageProp('statusBarHeight') statusBarHeight: number = 0  //状态栏高度

  tabs: string[] = ['位置', '支付方式', '租金', '排序']
  @State page: number = 1       //分页查询页码
  @State total: number = 0      //总数据
  @State dataSource: RecommendDataSource = new RecommendDataSource()  //懒加载数据源

  @State isShowRefresh: boolean = true  //是否显示刷新
  @State isNoData:boolean = false       //是否为空数据

  @State provinceCode:string = ''             //省份代码
  @State isShowAddressFilter:boolean = false  //是否显示地址筛选条件
  @State addressParam: RecommendParams = { page: 1, limit: 10, pSelIdx: 0, provinceCode: '11', cSelIdx: 0, cityCode: '', dSelIdx: 0, districtCode: '', districtName: ''}

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
      ForEach(this.tabs, (_: string, idx:number) => {
        Row({ space: 2 }) {
          Text(this.handlerTabName(idx))
            .fontSize(14)
            .fontColor(this.handlerTabColor(idx))
            .fontWeight(FontWeight.Medium)

          Image($r('app.media.arrow_down'))
            .width(12)
            .aspectRatio(1)
            .fillColor(this.handlerTabColor(idx))
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
      AddressPicker({
        addressParam: this.addressParam,
        onEmptyClick: () => {
          this.isShowAddressFilter = false
        },
        onResetClick: () => {
         this.resetAddressFilterParam()
        },
        onCheckClick: (address:RecommendParams) => {
          this.updateAddressFilterParam(address)
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
      this.requestRecommendData()
    })
  }

  //瀑布流尾部上拉加载组件
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

  handlerTabName(idx:number) {
    if(idx == FilterType.address) {
      let name = this.addressParam.districtName ? this.addressParam.districtName : this.tabs[0]
      name = name.length > 4 ? (name.substring(0,4) + '...'): name
      return name
    }
    return this.tabs[idx]
  }

  handlerTabColor(idx:number) {
    if(idx == FilterType.address) {
      return this.addressParam.districtName ? '#67C0A8' : '#000000'
    }
    return '#000000'
  }

  //请求房源推荐数据
  async requestRecommendData(isReset:boolean = false) {
    this.isShowRefresh = true
    const totalCount = this.dataSource.totalCount()
    if(totalCount != 0 && totalCount >= this.total && !isReset) {
      this.isShowRefresh = false
      return
    }

    let params: RecommendParams = {
      page: this.page,
      limit: 10,
      provinceCode: this.addressParam?.provinceCode,
      cityCode: this.addressParam?.cityCode,
      districtCode: this.addressParam?.districtCode,
    }

    const rsp = await httpUtil.get<RecommendRoomModel>(Api.recommendInfo, params)
    if(this.page == 1) { //刷新
      this.dataSource.setList(rsp.records)
    } else {        //翻页
      this.dataSource.pushList(rsp.records)
    }
    this.isShowRefresh = false
    this.total = Number(rsp.total)
    this.isNoData = rsp.records.length == 0
  }

  //处理数据
  handlerText(item: ActivityItem): string {
    // Reflect是供了对对象操作的方法：get、set、delete等
    return Reflect.get(item, '#text')
  }

  //更新地址查询条件
  updateAddressFilterParam(address: RecommendParams) {
    this.addressParam = address
    this.provinceCode = address.provinceCode ?? ''
    this.isShowAddressFilter = false
    console.log('address == ', JSON.stringify(address))
    this.requestRecommendData()
  }

  //重置地址查询条件
  resetAddressFilterParam() {
    this.isShowAddressFilter = false
    this.addressParam = {
      page: 1,
      limit: 10,
      pSelIdx: 0,
      provinceCode: '11',
      cSelIdx: 0,
      cityCode: '',
      dSelIdx: 0,
      districtCode: '',
      districtName: ''
    }

    this.requestRecommendData(true)
  }
}

