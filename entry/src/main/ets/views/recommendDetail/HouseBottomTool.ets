import VerticalItem from "../../components/VerticalItem"

//底部工具栏
@Component
export struct HouseBottomTool {
  build() {
    Row({space: 14}) {
      VerticalItem({
        img: $r('app.media.like'),
        name:'99+',
        fontSize: 10,
        fontColor: '#999',
      }).layoutWeight(0.4)

      VerticalItem({
        img: $r('app.media.message'),
        name:'咨询',
        fontSize: 10,
        fontColor: '#999',
      }).layoutWeight(0.4)

      Button('立即预定')
        .height(34)
        .type(ButtonType.Normal)
        .layoutWeight(1)
        .fontSize(14)
        .fontColor('#fff')
        .fontWeight(FontWeight.Medium)
        .borderRadius(2)
        .backgroundColor('#24A17B')

      Button('去看房')
        .height(34)
        .type(ButtonType.Normal)
        .layoutWeight(1)
        .fontSize(14)
        .fontColor('#fff')
        .fontWeight(FontWeight.Medium)
        .borderRadius(2)
        .backgroundColor('#36D1A1')
    }
    .width('100%')
    .padding({ top: 8, left: 25, bottom: 8, right: 15 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}