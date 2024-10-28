import { SupportItem, SupportList } from "../../models/recommend/RecommendRoomDetailModel"

//住房保障
@Component
export struct HouseProtection {
  @Prop supportList: SupportList

  build() {
    Column() {
      Text('租住服务与保障')
        .fontSize(18)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Text('谷粒专享')
        .fontSize(12)
        .fontColor('#666')
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 14 })

      GridRow({ columns: 2, gutter: { y: 15 } }) {
        ForEach(this.supportList, (item: SupportItem) => {
          GridCol() {
            this.serviceItemBuilder(item)
          }
        }, (item: SupportItem) => item.title)
      }

      Button('查看全部内容')
        .width('100%')
        .height(44)
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontColor('#ABA9AC')
        .fontWeight(FontWeight.Medium)
        .borderStyle(BorderStyle.Solid)
        .borderWidth(1)
        .borderColor('#F5F5F5')
        .backgroundColor('#fff')
        .margin({ top: 20 })
    }
    .width('100%')
    .padding({ bottom: 15 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  serviceItemBuilder($: SupportItem) {
    Row({ space: 10 }) {
      Image($.image).width(28).aspectRatio(1).objectFit(ImageFit.Contain)
      Column() {
        Text($.title).fontSize(14).fontColor('#000').fontWeight(FontWeight.Medium)
        Text($.subTitle).fontSize(10).fontColor('#666').fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}