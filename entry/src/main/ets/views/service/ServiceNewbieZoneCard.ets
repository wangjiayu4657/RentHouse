import { NewcomerZoneItem } from '../../models/service/ServiceModel'

//新人专区组件
@Component
export default struct ServiceNewbieZone {
  @Prop newcomerZoneItem: NewcomerZoneItem

  build() {
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
    .alignItems(HorizontalAlign.Start)
  }
}