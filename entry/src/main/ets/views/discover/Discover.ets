@Component
export struct Discover {
  @State message: string = 'Discover';

  build() {
    Grid() {
      ForEach(['1', '2', '3', '4', '5', '6', '7', '8', '9'], (item: string) => {
        GridItem() {
          Text(item)
            .height(100)
        }
        .width('100%')
        // .height('100%')
        .backgroundColor(Color.Orange)
      })
    }
    .width('100%')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(10)
    .rowsGap(10)
  }
}