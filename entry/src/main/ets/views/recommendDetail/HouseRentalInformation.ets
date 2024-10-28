import { DiscountsItem, MetaInfoItem, RecommendRoomDetailModel } from "../../models/recommend/RecommendRoomDetailModel"

interface RentItemInterface {
  title: string
  desc?: string
  isReport?:boolean
}

//房屋租赁信息
@Component
export struct HouseRentalInformation {
  @Prop detailModel?: RecommendRoomDetailModel

  build() {
    Column() {
      Row() {
        Text('￥').textStyle(14).margin({ top: 4 })
        Text(this.detailModel?.rentPriceUnitListing).textStyle(26)
        Text(this.detailModel?.rentPriceUnit).textStyle(14).margin({ top: 4 })

        Blank()

        Text('租金试算').textStyle(12, '#999')

        Image($r('app.media.arrow_right'))
          .width(14)
          .height(8)
          .objectFit(ImageFit.Contain)
          .fillColor('#999')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      this.rentDetailListBuilder()

      Row({ space: 4 }) {
        this.houseInfoBuilder()

        Column({ space: 4 }) {
          Column({ space: 6 }) {
            Row({ space: 4 }) {
              Text('8号线')
                .textStyle(10, '#fff', FontWeight.Medium)
                .backgroundColor($r('app.color.primary'))
                .borderRadius(4)
                .padding({
                  top: 3,
                  left: 7,
                  bottom: 3,
                  right: 7
                })
              Text('后沙峪地铁站').textStyle(12, '#000', FontWeight.Medium)
              Blank()
              Image($r('app.media.arrow_right')).width(14).height(8).objectFit(ImageFit.Contain)
            }
            .width('100%')

            Row({ space: 4 }) {
              Text('步行约').textStyle(12, '#999', FontWeight.Medium)
              Text('1.5公里').textStyle(12, '#FF4141', FontWeight.Medium)
            }
            .width('100%')
          }
          .layoutWeight(1)
          .backgroundColor('#F8F8FB')
          .justifyContent(FlexAlign.Center)
          .borderRadius(4)

          Column({ space: 6 }) {
            Row({ space: 4 }) {
              Image($r('app.media.recommend_package')).size({ width: 16, height: 16 })
              Text('设置公司').textStyle(12, '#000', FontWeight.Medium)
              Blank()
              Image($r('app.media.arrow_right')).width(14).height(8).objectFit(ImageFit.Contain)
            }
            .width('100%')

            Text('这里查看到公司需要多久').textStyle(12, '#999', FontWeight.Medium).width('100%')
          }
          .layoutWeight(1)
          .backgroundColor('#F8F8FB')
          .justifyContent(FlexAlign.Center)
          .borderRadius(4)
        }
        .height('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(104)
      .margin({ top: 15 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Color.White)

      Row({ space: 12 }) {
        ForEach(['省心长签', '免物业费', '离地铁近', '谷粒 6.0', '非首次'], (item: string) => {
          Text(item)
            .fontSize(10)
            .fontColor('#000')
            .fontWeight(FontWeight.Medium)
            .padding({
              top: 4,
              left: 8,
              bottom: 4,
              right: 8
            })
            .backgroundColor('#F8F8FB')
            .borderRadius(4)
        })
      }
      .width('100%')
      .height(20)
      .margin({ top: 8 })
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        this.horizontalItemBuilder({ title: '入住', desc: this.detailModel?.rentTerm.term })
        this.horizontalItemBuilder({ title: '租期', desc: this.detailModel?.rentTerm.checkInTime })
        this.horizontalItemBuilder({ title: '厨房', desc: this.detailModel?.rentTerm.kitchen })
        this.horizontalItemBuilder({ title: '年代', desc: this.detailModel?.rentTerm.year })
        this.horizontalItemBuilder({ title: '电梯', desc: this.detailModel?.rentTerm.lift })
        this.horizontalItemBuilder({ title: '装修', desc: this.detailModel?.rentTerm.renovation })
        this.horizontalItemBuilder({ title: '上架', desc: this.detailModel?.rentTerm.grounding })
        this.horizontalItemBuilder({ title: '供暖', desc: this.detailModel?.rentTerm.heating })
        this.horizontalItemBuilder({ title: '绿化', desc: this.detailModel?.rentTerm.green })
        this.horizontalItemBuilder({ title: '环保', desc: this.detailModel?.rentTerm.protection, isReport: true })
        this.horizontalItemBuilder({ title: '小区', desc: this.detailModel?.rentTerm.house }, '#FF4141')
      }
      .width('100%')
      .margin({ top: 8 })

      Row({ space: 6 }) {
        Text('*部分房源信息详见底部详解').fontSize(10).fontColor('#999').fontWeight(FontWeight.Medium)
        Blank()
        Text('房屋状况说明书').fontSize(10).fontColor('#999').fontWeight(FontWeight.Medium)
        Image($r('app.media.arrow_right')).height(8).fillColor('#999')
      }
      .width('100%')
      .height(12)
      .margin({ top: 8 })
    }
    .width('100%')
  }

  @Builder
  rentDetailListBuilder() {
    List() {
      ForEach(this.detailModel?.discounts, (item: DiscountsItem) => {
        ListItem() {
          this.rentDetailBuilder(item.image, item.txt)
        }
      })
    }
    .width('100%')
  }

  //租金
  @Builder
  rentDetailBuilder(icon: ResourceStr, text: string) {
    Row({ space: 8 }) {
      Image(icon)
        .height(20)
        .objectFit(ImageFit.Contain)

      Text(text)
        .textStyle(12, '#999', FontWeight.Medium)

      Blank()

      Image($r('app.media.arrow_right'))
        .width(14)
        .height(8)
        .objectFit(ImageFit.Contain)
        .fillColor($r('app.color.primary'))
    }
    .width('100%')
    .margin({ top: 8 })
  }

  @Builder
  houseInfoBuilder() {
    Row() {
      GridRow({ columns: 2, gutter: { y: 10 } }) {
        ForEach(this.detailModel?.metaInfo, (item: MetaInfoItem, idx: number) => {
          GridCol() {
            this.verticalItemBuilder(item.name, item.desc, idx)
          }
          .width('50%')
          .height('50%')
        })
      }
      .width('100%')
      .height('100%')
      .padding({
        top: 10,
        left: 15,
        bottom: 10,
        right: 15
      })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.SpaceAround)
    .backgroundColor('#F8F8FB')
    .borderRadius(4)
  }

  @Builder
  verticalItemBuilder(title: string, desc: string, idx: number) {
    Column({ space: 6 }) {
      Text(title).textStyle(12, '#999', FontWeight.Medium)
      Text(desc).textStyle(14, '#000', FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .padding({ left: idx % 2 == 0 ? 0 : 15 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  horizontalItemBuilder($: RentItemInterface, color: ResourceColor = '#000') {
    Row() {
      Text($.title).fontSize(14).fontColor('#999').fontWeight(FontWeight.Medium)
      Text($.desc ?? '').fontSize(14).fontColor(color).fontWeight(FontWeight.Medium).margin({ left: 15})

      if($.isReport) { //如果是查看报告
        Button('查看报告')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontColor('#999')
          .fontWeight(FontWeight.Medium)
          .padding({top: 8, left: 10, bottom: 8, right: 6})
          .backgroundColor(Color.Transparent)
          .onClick(() => { })

        Image($r('app.media.arrow_right'))
          .width(4)
          .height(8)
          .fillColor('#999')
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .height(32)
    .justifyContent(FlexAlign.Start)
  }
}


@Extend(Text)
function textStyle(fontSize: number, fontColor: ResourceColor = '#000', fontWeight: FontWeight = FontWeight.Bold) {
  .fontSize(fontSize)
  .foregroundColor(fontColor)
  .fontWeight(fontWeight)
}