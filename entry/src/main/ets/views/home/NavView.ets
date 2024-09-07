import { NavItem, NavList } from '../../models/home/HomeModel'

@Component
export default struct NavView {
  @Prop navList:NavList

  build() {
    GridRow({
      gutter: 16,
      columns: { xs: 2, sm: 4, md: 4, lg: 4, xl: 8, xxl: 8 },
      breakpoints: { value: ['320vp','520vp', '840vp', '1080vp'] }
    }) {
      ForEach(this.navList, (navItem: NavItem) => {
        GridCol() {
          this.itemBuilder(navItem)
        }
      }, (navItem: NavItem) => navItem.id + '')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  itemBuilder(navItem:NavItem) {
    Column({space: 8}) {
      Image(navItem.imageURL)
        .width(56)
        .aspectRatio(1)
        .objectFit(ImageFit.Fill)

      Text(navItem.title)
        .fontSize(12)
        .height(14)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(80)
  }
}