import { BannerItem } from '../../models/home/HomeModel'
import { BannerDataSource } from '../../models/home/BannerDataSource'

@Component
export struct Banner {
  @ObjectLink bannerSource: BannerDataSource

  build() {
    Swiper() {
      LazyForEach(this.bannerSource, (banner: BannerItem) => {
        Image(banner.imageURL)
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Fill)
      }, (item: BannerItem) => item.id.toString())
    }
    .width('100%')
    .height(211)
    .loop(true)
    .autoPlay(true)
    .indicator(Indicator.dot().color('#cccbcb').selectedColor($r('app.color.primary')))
  }
}