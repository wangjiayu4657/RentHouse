import { BannerItem, BannerList } from '../../models/home/homeModel'

@Component
export struct Banner {
  @Prop bannerList: BannerList

  build() {
    Swiper() {
      ForEach(this.bannerList, (banner: BannerItem) => {
        Image(banner.imageURL)
      }, (item: BannerItem) => item.id.toString())
    }
    .width('100%')
    .height(211)
    .loop(true)
    .autoPlay(true)
    .indicator(Indicator.dot().color('#cccbcb').selectedColor($r('app.color.primary')))
  }
}