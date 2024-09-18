@Component
export default struct ServiceCardHeader {
  leadTitle:string = ''
  tailTitle:string = '全部服务'

  build() {
    Row({space : 4}) {
      Text(this.leadTitle)
        .fontSize(16)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)

      Blank()

      Text(this.tailTitle)
        .fontSize(12)
        .fontColor('#999')
        .fontWeight(FontWeight.Medium)

      Image($r('app.media.arrow_right'))
        .width(4)
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height(32)
    .justifyContent(FlexAlign.SpaceBetween)

  }
}