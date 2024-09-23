import { router } from '@kit.ArkUI'

//导航栏
@Component
export default struct NavigationBar {
  @State title: string = ''

  build() {
    RelativeContainer() {
      Image($r('app.media.arrow_back'))
        .width(24)
        .aspectRatio(1)
        .objectFit(ImageFit.Contain)
        .alignRules({
          left: { anchor: '__container__', align: HorizontalAlign.Start },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
        .offset({ x: 10 })
        .onClick(() => router.back())

      Text(this.title)
        .id('RecommendPageHelloWorld')
        .fontSize(16)
        .fontColor('#000')
        .fontWeight(FontWeight.Medium)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .width('100%')
    .height('100%')
  }
}