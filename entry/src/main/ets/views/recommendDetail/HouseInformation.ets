import { RentInfoItem, RentInfoList } from "../../models/recommend/RecommendRoomDetailModel"

//房屋信息
@Component
export struct HouseInformation {
  @Prop rentList: RentInfoList

  build() {
    Column({ space: 8 }) {
      Text('房屋信息')
        .fontSize(18)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      this.rentInfoListBuilder()

      Text('*已出租房屋为您展示房屋签约人信息')
        .fontSize(10)
        .fontColor('#999')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  rentInfoListBuilder() {
    List({ space: 8 }) {
      ForEach(this.rentList, (item: RentInfoItem) => {
        ListItem() {
          this.rentInfoItemBuilder(item)
        }
      }, (item: RentInfoItem) => item.userTag)
    }
    .width('100%')
    .height('auto')
  }

  @Builder
  rentInfoItemBuilder($: RentInfoItem) {
    Row({ space: 8 }) {
      Image($.image).width(34).aspectRatio(1).objectFit(ImageFit.Contain)
      Text($.title).fontSize(12).fontColor('#000').fontWeight(FontWeight.Medium)
      Blank()
      Text($.userTag).fontSize(12).fontColor('#999').fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(42)
    .padding({ left: 10, right: 10 })
    .borderRadius(4)
    .backgroundColor('#FAF8FB')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}