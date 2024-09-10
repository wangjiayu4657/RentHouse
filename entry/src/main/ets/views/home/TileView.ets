import { TileItem, TileList } from '../../models/home/HomeModel'

@Component
export default struct TileView {
  @Prop tileList:TileList = []

  build() {
    Grid() {
      ForEach(this.tileList, (tileItem:TileItem) => {
        GridItem() {
          this.gridItemBuilder(tileItem)
        }
      }, (tileItem:TileItem) => tileItem.id + '')
    }
    .width('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(15)
    .scrollBar(BarState.Off)
    .enabled(true)
  }

  @Builder
  gridItemBuilder(tileItem:TileItem) {
    Column({space : 10}) {
      Image(tileItem.imageURL)
        .width('100%')
        .objectFit(ImageFit.Fill)

      Row({space: 5}) {
        Text(tileItem.title)
          .fontSize(12)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)

        Text(tileItem.sub_title)
          .fontSize(10)
          .fontColor('#999')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({left: 4})
    }
    // .backgroundColor(Color.Blue)
  }
}