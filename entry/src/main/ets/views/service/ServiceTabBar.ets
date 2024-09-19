import {
  CleaningServiceInfoItem,
  CleaningServiceInfoList,
  NewcomerZoneItem
} from '../../models/service/ServiceModel'


@Component
export default struct ServiceTab {
  @State idx: number = 0
  @Prop newcomerZoneItem: NewcomerZoneItem
  @Prop cleanServiceInfoList: CleaningServiceInfoList
  private titles: string[] = ['会员精选', '居家保洁', '深层清洗', '新居乔迁']
  private subTitles: string[] = ['专业服务', '解放双手', '高温蒸洗', '一站搬家']

  build() {
    Tabs() {
      ForEach(this.titles, (item: string, idx: number) => {
        TabContent() {
          this.tabContentBuilder()
        }.tabBar(this.tabBarBuilder(item, idx))
      }, (item: string) => item)
    }
    .width('100%')
    .height('100%')
    .scrollable(true)
    .onChange((idx: number) => {
      this.idx = idx
      console.log('idx == ', idx)
    })
  }

  @Builder
  tabBarBuilder(title: string, idx: number) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(this.idx == idx ? 18 : 14)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)

      Text(this.subTitles[idx])
        .fontSize(12)
        .fontColor('#666')
        .fontWeight(FontWeight.Medium)

      if (this.idx == idx) {
        Line()
          .width(20)
          .height(4)
          .backgroundColor('#51BB9E')
      }
    }
  }

  @Builder
  tabContentBuilder() {
    Column({space: 8}) {
      //新人专区组件
      this.newbieZoneBuilder()

      //洁净家组件
      this.cleanHouseBuilder()
    }
  }

  @Builder
  newbieZoneBuilder() {
    Column({ space: 8 }) {
      Text() {
        Span('新人')
          .fontSize(16)
          .fontColor('#36D1A1')
          .fontWeight(FontWeight.Bold)

        Span('专区')
          .fontSize(16)
          .fontColor('#000')
          .fontWeight(FontWeight.Bold)
      }

      Image(this.newcomerZoneItem.img)
        .width('100%')
        .objectFit(ImageFit.Cover)
    }
    .width('100%')
    .padding(8)
    .margin({top: 15})
    .borderRadius(8)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  cleanHouseBuilder() {
    Column({ space: 8 }) {
      //标题
      Text('洁净家').textStyle(16, '#000', FontWeight.Bold)

      //服务选项
      Grid() {
        ForEach(this.cleanServiceInfoList, (item: CleaningServiceInfoItem) => {
          GridItem() {
            this.serviceCleanItemBuilder(item)
          }
        }, (item: CleaningServiceInfoItem) => item.title)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
    }
    .width('100%')
    .padding(8)
    .borderRadius(8)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  serviceCleanItemBuilder($: CleaningServiceInfoItem) {
    Column({ space: 8 }) {
      Image($.img)
        .height(115)
        .objectFit(ImageFit.Cover)

      Text($.title).textStyle(14, '#000', FontWeight.Bold)
      Text($.subTitle).textStyle(10, '#666', FontWeight.Medium)
      Text() {
        Span('到手价').spanStyle(10, '#666', FontWeight.Medium)
        Span(` ￥${$.priceAfterDiscounts} `).spanStyle(16, '#D9351A', FontWeight.Medium)
        Span(`￥${$.originalPrice}`)
          .spanStyle(10, '#666', FontWeight.Medium)
          .decoration({ type: TextDecorationType.LineThrough })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Extend(Text)
function textStyle(size: number, color: ResourceColor, weight: FontWeight) {
  .fontSize(size)
  .fontColor(color)
  .fontWeight(weight)
}

@Extend(Span)
function spanStyle(size: number, color: ResourceColor, weight: FontWeight) {
  .fontSize(size)
  .fontColor(color)
  .fontWeight(weight)
}