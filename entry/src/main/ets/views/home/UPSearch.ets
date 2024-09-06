
@Component
export default struct UPSearch {
  build() {
    Row({space: 12}) {
      //地名
      Text('北京')
        .fontSize(14)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)

      //搜索框
      this.searchBuilder()

      //右侧图标
      Image($r('app.media.message'))
        .width(24)
        .aspectRatio(1)
        .fillColor(Color.White)
    }
    .width('100%')
    .height(56)
    .padding({left: 15, right: 15})
  }

  @Builder
  searchBuilder() {
    Row({space: 12}) {
      //搜索左侧图标
      Image($r('app.media.search'))
        .width(18)
        .aspectRatio(1)

      //搜索输入文本框
      TextInput({placeholder: '公司/地铁/小区，马上搜索'})
        .placeholderColor('#999')
        .placeholderFont({size:12})
        .backgroundColor(Color.Transparent)
        .padding({left: 0, right: 0})
        .caretColor('#999')
        .layoutWeight(1)

      //竖直分割线
      Line()
        .width(1)
        .height(18)
        .backgroundColor('#D7D7D7')

      //搜索右侧图标
      Image($r('app.media.position'))
        .width(18)
        .aspectRatio(1)
    }
    .height(38)
    .layoutWeight(1)
    .borderRadius(19)
    .padding({left: 15, right: 15})
    .backgroundColor(Color.White)
  }
}