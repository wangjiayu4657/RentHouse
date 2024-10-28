import { HousePictureItem, HousePictureList } from '../../models/recommend/RecommendRoomDetailModel'

//房屋展示
@Component
export struct HouseDisplay {
  @State selIdx: number = 0
  @Prop @Watch('createSwiperCtrl') picList: HousePictureList
  swiperCtrlList: SwiperController[] = []

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.picList, (picItem: HousePictureItem, idx: number) => {
        TabContent() {
          this.roomPictureDisplayBuilder(picItem, this.swiperCtrlList[idx])
        }.tabBar(this.tabBarBuilder(picItem.spaceName + `(${picItem.picList.length})`, idx))
      }, (picItem: HousePictureItem) => picItem.spaceName)
    }
    .barMode(BarMode.Scrollable)
    .onChange((index: number) => {
      this.selIdx = index
    })
    .onTabBarClick((index: number) => {
      //点击 tab 时从每组的第一张图片开始展示
      this.swiperCtrlList[index].changeIndex(0, true)
    })
  }

  @Builder
  tabBarBuilder(txt:string, idx: number) {
    Column({space : 4}) {
      Text(txt)
        .fontSize(16)
        .fontColor(this.selIdx == idx ? $r('app.color.primary') : '#000')
        .fontWeight(FontWeight.Medium)

      Line()
        .width('45%')
        .height(2)
        .backgroundColor(this.selIdx == idx ? $r('app.color.primary') : Color.Transparent)
    }
    .width(70)
    .padding(6)
  }

  @Builder
  roomPictureDisplayBuilder($: HousePictureItem, ctrl: SwiperController) {
    Swiper(ctrl) {
      ForEach($.picList, (item: string) => {
        Image(item)
          .width('94%')
          .height('100%')
          .objectFit(ImageFit.Fill)
          .borderRadius(4)
      })
    }
    .loop(false)
    .autoPlay(false)
    .itemSpace(15)
    .nestedScroll(SwiperNestedScrollMode.SELF_FIRST)
    .indicator(
      new DotIndicator()
        .color(Color.White)
        .selectedColor($r('app.color.primary'))
    )
  }

  //创建 SwiperController
  createSwiperCtrl(): void {
    for (let i = 0; i < this.picList.length; i++) {
      let sCtrl: SwiperController = new SwiperController()
      this.swiperCtrlList.push(sCtrl)
    }
  }
}