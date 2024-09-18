import { ServiceActivityItem } from '../../models/service/ServiceModel'
import ServiceCardHeader from './ServiceCardHeader'

//服务日历组件
@Component
export struct ServiceCalendarCard {
  @State idx: number = 0
  @State month: number = 0
  @State scaleFont: number = 14

  @Prop serviceActivity: ServiceActivityItem

  private months: string[] = ['10', '11', '12', '01', '02', '03']
  private titles: string[] = ['会员精选', '居家保洁', '深层清洗', '新居乔迁']
  private subTitles: string[] = ['专业服务', '解放双手', '高温蒸洗', '一站搬家']

  build() {
    Column() {
      //卡片头部组件
      ServiceCardHeader({ leadTitle: '服务日历', tailTitle: '全部服务' })
        .width('100%')
        .padding(12)

      this.ServiceCardBodyBuilder()
    }
    .width('100%')
  }

  @Builder
  ServiceCardBodyBuilder() {
    Column() {
      this.cardHeaderBuilder()
      this.cardBodyBuilder()
      this.cardFooterBuilder()
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
        .backgroundColor(this.month == idx ? '#CDFFD9' : '#FFFFFF')
        .onClick(() => {
          this.month = idx
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
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height(140)
    .padding({ top: 8, left: 12, bottom: 8, right: 12 })
    .margin({top: 12, bottom: 22})
    .alignItems(HorizontalAlign.Start)
    .backgroundImage($r("app.media.service_calendar_bg"))
    .backgroundImageSize(ImageSize.FILL)

  }

  @Builder
  cardFooterBuilder() {
    Row({space: 20}) {
      ForEach(this.titles, (item: string, idx: number) => {
        this.cardFooterItemBuilder(item, idx)
      })
    }
    .width('100%')
    .padding({left: 12, right: 12, bottom: 12})
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  cardFooterItemBuilder(title: string, idx: number) {
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
    .onClick(() => {
      this.idx = idx
    })
  }
}