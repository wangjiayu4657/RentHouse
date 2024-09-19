import ServiceCardHeader from './ServiceCardHeader'
import { getCurrentMonth, getMonths } from '../../utils/DateUtil'
import { ServiceActivityItem } from '../../models/service/ServiceModel'

//服务日历组件
@Component
export struct ServiceCalendarCard {
  @State curMonthIdx: number = 0
  @Prop serviceActivity: ServiceActivityItem

  private months: string[] = getMonths()

  aboutToAppear(): void {
    let curMonth = getCurrentMonth()
    this.curMonthIdx = this.months.indexOf(curMonth.toString())
  }

  build() {
    Column() {
      //卡片头部组件
      ServiceCardHeader({ leadTitle: '服务日历', tailTitle: '全部服务' })
        .width('100%')
        .padding(12)

      this.serviceCardBodyBuilder()
    }
    .width('100%')
  }

  @Builder
  serviceCardBodyBuilder() {
    Column() {
      //卡片头部组件
      this.cardHeaderBuilder()
      //卡片内容组件
      this.cardBodyBuilder()
    }
  }

  @Builder
  cardHeaderBuilder() {
    Row({ space: 24 }) {
      ForEach(this.months, (item: string, idx:number) => {
        Text() {
          Span(item)
            .fontSize(16)
            .fontColor('#000')
            .fontWeight(FontWeight.Bold)

          Span('月')
            .fontSize(12)
            .fontColor('#666')
            .fontWeight(FontWeight.Medium)
        }
        .padding(8)
        .borderRadius(4)
        .backgroundColor(this.curMonthIdx == idx ? '#CDFFD9' : '#FFFFFF')
        .onClick(() => {
          this.curMonthIdx = idx
        })
      })
    }
    .width('100%')
    .padding({ left: 12, right: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  cardBodyBuilder() {
    Column({space :8}) {
      Text(this.serviceActivity.name)
        .fontSize(14)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)

      Row({space: 10}) {
        Image(this.serviceActivity.img)
          .width(100)
          .aspectRatio(1)
          .objectFit(ImageFit.Fill)

        Column({ space: 8 }) {
          Text(this.serviceActivity.title)
            .fontSize(14)
            .fontColor('#000')
            .fontWeight(FontWeight.Medium)

          Text(this.serviceActivity.subTitle)
            .fontSize(12)
            .fontColor('#000')
            .fontWeight(FontWeight.Medium)
        }
        .offset({ y: 8 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('立即参与')
          .type(ButtonType.Normal)
          .width(80)
          .height(24)
          .fontSize(12)
          .fontColor('#1F632F')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#CDFFD9')
          .borderRadius(4)
          .alignSelf(ItemAlign.End)
      }
      .width('100%')
      .padding({top: 4})
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height(140)
    .padding({ top: 16, left: 12, bottom: 8, right: 12 })
    .margin({top: 12, bottom: 22})
    .alignItems(HorizontalAlign.Start)
    .backgroundImage($r("app.media.service_calendar_bg"))
    .backgroundImageSize(ImageSize.FILL)
  }
}