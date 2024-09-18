import VerticalItem from '../components/VerticalItem';

@Preview
@Component
export struct ToSee {
  @State message: string = 'To See';
  @StorageProp('statusBarHeight') statusBarHeight: number = 0

  build() {
    Column() {
      this.headerBuilder()
      this.bodyBuilder()
    }
    .width('100%')
    .height('100%')
    .padding({top: this.statusBarHeight})
    .linearGradient({
      angle: 180,
      colors: [["#DEFBE5", 0], ["#FFFFFF", 0.5]]
    })
  }

  @Builder
  headerBuilder() {
    Row() {
      Row({ space: 8 }) {
        Image($r('app.media.bag'))
          .id('bagIconId')
          .width(16)

        Text('填写通勤地址')
          .id('addressId')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }

      Row({ space: 28 }) {
        VerticalItem({img: $r('app.media.message'), name: '消息'})
        VerticalItem({img: $r('app.media.journey'), name: '行程'})
      }
    }
    .width('100%')
    .padding({ left: 15, right: 15 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  bodyBuilder() {
    Column() {
      Image($r('app.media.find_room'))
        .width(60)

      Text('发现你想看的房子')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 20 })

      Image($r('app.media.blank'))
        .width(234)
        .objectFit(ImageFit.Contain)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 10 })

      Text('暂无想看房源，试试如下找房方式')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 10 })


      Row({space: 20}) {
        this.bodyItemBuilder($r('app.media.bus'), '通勤找房', '按公司通勤时长找房')
        this.bodyItemBuilder($r('app.media.map'), '地图找房', '在你想住的地方找房')
      }
      .margin({top: 20})
      .alignSelf(ItemAlign.Center)
    }
    .width('100%')
    .padding({ top: 50, left: 15, right: 15 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  bodyItemBuilder(img:ResourceStr, title:string, desc:string) {
    Row({ space: 6 }) {
      Image(img)
        .width(34)
        .objectFit(ImageFit.Contain)

      Column({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)

        Text(desc)
          .fontSize(10)
          .fontColor('#999999')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)
    }
  }
}