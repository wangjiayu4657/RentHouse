import { CleaningServiceInfoItem, CleaningServiceInfoList } from '../../models/service/ServiceModel'

//洁净家组件
@Component
export default struct ServiceCleanHouse {
  @Prop cleanServiceInfoList: CleaningServiceInfoList

  build() {
    Column({ space: 8 }) {
      //标题
      Text('洁净家').textStyle(16, '#000', FontWeight.Bold)

      //服务选项
      Grid() {
        ForEach(this.cleanServiceInfoList, (item:CleaningServiceInfoItem) => {
          GridItem() {
            this.serviceCleanItemBuilder(item)
          }
        }, (item:CleaningServiceInfoItem) => item.title)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  serviceCleanItemBuilder($:CleaningServiceInfoItem) {
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