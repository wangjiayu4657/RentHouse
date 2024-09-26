import Api from '../../service/http/Api';
import httpUtil from '../../service/http/HttpUtil'
import RoomCard from '../../views/home/RoomCard';
import NavigationBar from '../../components/NavigationBar';
import AddressPicker from '../../views/recommend/AddressPicker'
import FilterPayment from '../../views/recommend/FilterPayment';
import { emitter } from '@kit.BasicServicesKit';
import { RecommendDataSource } from '../../models/recommend/RecommendDataSource';
import {
  ActivityItem,
  RecommendParams,
  RecommendRoomModel,
  RecordItem
} from '../../models/recommend/RecommendRoomModel'
import { JSON } from '@kit.ArkTS';


//筛选类型
enum FilterType {
  address, //地址
  pay,     //支付方式
  rent,    //租金
  sort     //排序
}


@Entry
@Component
struct RecommendPage {
  type:FilterType = FilterType.address
  tabs: string[] = ['位置', '支付方式', '租金', '排序'] //筛选条件类型
  @StorageProp('statusBarHeight') statusBarHeight: number = 0 //状态栏高度
  @State total: number = 0 //总数据
  @State dataSource: RecommendDataSource = new RecommendDataSource() //懒加载数据源
  @State isShowRefresh: boolean = true //是否显示刷新
  @State isNoData: boolean = false //是否为空数据
  @State isShowAddressPicker: boolean = false //是否显示地址筛选条件
  @State isShowFilterPayment: boolean = false //是否显示支付方式筛选条件
  @State params: RecommendParams = new RecommendParams() //请求参数

  aboutToAppear(): void {
    this.requestRecommendData()

    //点击空白地方隐藏所有条件筛选组件
    emitter.on('emptyClick', () => {
      this.hiddenFilterView()
    })

    //重置条件
    emitter.on('resetFilter', () => {
      this.hiddenFilterView()
      this.requestRecommendData(true)
    })

    //更新条件查询数据
    emitter.on<RecommendParams>('searchFilter', () => {
      this.hiddenFilterView()
      this.requestRecommendData()
    })
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

  //导航组件
  @Builder
  navigationBarBuilder() {
    NavigationBar({ title: '房源推荐' })
      .width('100%')
      .height(44 + this.statusBarHeight)
      .padding({ top: this.statusBarHeight })
      .backgroundColor(Color.White)
  }

  //筛选项组件
  @Builder
  filterItemBuilder() {
    Row() {
      ForEach(this.tabs, (_: string, idx: number) => {
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
          this.type = idx
          this.onFilterTabClick(idx)
        })
      })
    }
    .width('100%')
    .height(40)
    .padding({ left: 15, right: 15 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  //推荐内容组件
  @Builder
  recommendBodyBuilder() {
    Stack() {
      if (this.isNoData) {
        this.emptyBuilder()
      } else {
        this.recommendRoomBuilder()
      }

      //地址筛选条件
      if(this.isShowAddressPicker) {
        AddressPicker({addressParam: this.params})
          .width('100%')
          .height('100%')
      }

      //支付方式筛选条件
      if(this.isShowFilterPayment) {
        FilterPayment({param : this.params})
          .width('100%')
          .height('100%')
      }
    }
    .layoutWeight(1)
    .backgroundColor('#F7F7F7')
  }

  @Builder
  recommendRoomBuilder() {
    WaterFlow({ footer: this.waterFlowFooterBuilder() }) {
      LazyForEach(this.dataSource, (item: RecordItem, idx: number) => {
        FlowItem() {
          this.flowItemBuilder(item)
        }
        .width('100%')
        .padding({ top: (idx == 0 || idx == 1) ? 15 : 10 })
        .height(item.activity ? 335 : 220)
      }, (item: RecordItem) => item.id)
    }
    .width('100%')
    .height('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .backgroundColor('#F7F7F7')
    .padding({ left: 15, right: 15 })
    .onReachEnd(() => {
      this.params.page++
      this.requestRecommendData()
    })
  }

  //瀑布流尾部上拉加载组件
  @Builder
  waterFlowFooterBuilder() {
    if (!this.isNoData) {
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
        .padding({
          top: 4,
          left: 8,
          bottom: 4,
          right: 8
        })
        .backgroundColor(item.activity.textBackGroundColor)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  //空数据组件
  @Builder
  emptyBuilder() {
    Column({ space: 15 }) {
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

  onFilterTabClick(type: FilterType) {
    if (type == FilterType.address) { //位置
      this.isShowFilterPayment = false
      this.isShowAddressPicker = true
    } else if (type == FilterType.pay) { //支付方式
      this.isShowAddressPicker = false
      this.isShowFilterPayment = true
    } else if (type == FilterType.rent) { //租金

    } else { //排序

    }
  }

  //处理条件类型回显数据
  handlerTabName(idx: number) {
    if (idx == FilterType.address) {
      let name = this.params.districtName ? this.params.districtName : this.tabs[0]
      name = name.length > 4 ? (name.substring(0, 4) + '...') : name
      return name
    } else if(idx == FilterType.pay) {
      let name = this.params.paymentTyp ? this.params.paymentTyp : this.tabs[1]
      return name
    }
    return this.tabs[idx]
  }

  //处理条件类型回显高亮显示
  handlerTabColor(idx: number) {
    if (idx == FilterType.address) {
      return this.params.districtName ? '#67C0A8' : '#000000'
    } else if( idx == FilterType.pay) {
      return this.params.paymentTyp ? '#67C0A8' : '#000000'
    }
    return '#000000'
  }

  //请求房源推荐数据
  async requestRecommendData(isReset: boolean = false) {
    const totalCount = this.dataSource.totalCount()
    if (totalCount != 0 && totalCount >= this.total && !isReset) {
      this.isShowRefresh = false
      return
    }

    if(isReset) {  //重置条件
      this.resetParam()
    }

    // console.log('param -- ', JSON.stringify(this.params))
    const rsp = await httpUtil.get<RecommendRoomModel>(Api.recommendInfo, this.params)
    if (this.params.page == 1) { //刷新
      this.dataSource.setList(rsp.records)
    } else { //翻页
      this.dataSource.pushList(rsp.records)
    }

    this.total = Number(rsp.total)
    this.isNoData = rsp.records.length == 0
    this.isShowRefresh = rsp.records.length == 10
  }

  //重置筛选条件
  resetParam() {
    if(this.type == FilterType.address) {
      this.params.resetAddressParam()
    } else if(this.type == FilterType.pay) {
      this.params.resetPayWayParam()
    } else if(this.type == FilterType.rent) {
      this.params.resetRentParam()
    } else {
      this.params.resetOrderParam()
    }
  }

  //处理数据
  handlerText(item: ActivityItem): string {
    // Reflect是供了对对象操作的方法：get、set、delete等
    return Reflect.get(item, '#text')
  }

  //隐藏筛选条件组件
  hiddenFilterView() {
    this.isShowAddressPicker = false
    this.isShowFilterPayment = false
  }
}

