import { RoomItem, RoomList, TagItem } from '../../models/home/HomeModel'
import { RecommendDataSource } from '../../models/home/RecommendDataSource'
import Api from '../../service/http/Api'
import httpUtil from '../../service/http/http'


@Component
export default struct RecommendView {
  @State rDataSource:RecommendDataSource = new RecommendDataSource()

  aboutToAppear(): void {
    this.requestRoomInfoData()
  }

  build() {
    Column({ space: 16 }) {
      this.headerBuilder()
      this.bodyBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_color'))
  }

  //头部组件
  @Builder
  headerBuilder() {
    Row() {
      Text() {
        Span('周边房源 ')
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Span('推荐')
          .fontSize(16)
          .fontColor($r('app.color.primary'))
          .fontWeight(FontWeight.Bold)
      }

      Row({ space: 4 }) {
        Text('更多推荐').textStyle(10, '#666')
        Image($r('app.media.arrow_right'))
          .width(4)
          .height(8)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .height(44)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 15, right: 15 })
    .backgroundColor(Color.White)
  }

  //内容组件
  @Builder
  bodyBuilder() {
    Grid() {
      LazyForEach(this.rDataSource, (item: RoomItem) => {
        GridItem() {
          this.gridItemBuilder(item)
        }
      }, (item: RoomItem) => item.id)
    }
    .width('100%')
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(12)
    .padding({ left: 15, right: 15 })
    .backgroundColor($r('app.color.bg_color'))
    .enabled(false)
  }

  //自定义 grid item 组件
  @Builder
  gridItemBuilder($: RoomItem) {
    Column() {
      //房间图片
      this.roomPictureBuild($)
      //房间信息
      this.roomInfoBuilder($)
    }
    .width('100%')
  }

  //房间图片
  @Builder
  roomPictureBuild(item: RoomItem) {
    Stack() {
      //房间图片
      Image(item.housePicture)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)
        .borderRadius({ topLeft: 8, topRight: 8 })

      //背景图片
      Image($r('app.media.room_text_bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)

      //房间位置
      Row({ space: 6 }) {
        Image($r('app.media.location'))
          .size({ width: 12, height: 14 })
          .fillColor(Color.White)
          .objectFit(ImageFit.Contain)

        Text(item.address).textStyle(10, Color.White)
      }
      .margin({ left: 8, bottom: 8 })
    }
    .width('100%')
    .height(120)
    .alignContent(Alignment.BottomStart)
  }

  //房间信息
  @Builder
  roomInfoBuilder(item: RoomItem) {
    Column({ space: 10 }) {
      //房间价格及面积
      Row() {
        Text(`${item.rentPriceListing}${item.rentPriceUnit}`).textStyle(14, '#E03810')
        Text(item.rentArea + '㎡').textStyle(10, '#999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      //房间出租方式描述
      Text(item.houseTitle)
        .textStyle(12, '#000')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      //房间优势描述
      Row({ space: 6 }) {
        ForEach(item.tags.slice(0, 2), (tag: TagItem, idx: number) => {
          if (idx == 0) {
            Button(tag.name).btnStyle(Color.White, $r('app.color.primary'))
          } else {
            Button(tag.name).btnStyle('#B3B3B3', $r('app.color.bg_color'))
          }
        }, (tag: string) => tag)
      }
      .width('100%')
    }
    .width('100%')
    .padding({top: 10 , left: 10, bottom: 10, right: 10})
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .borderRadius({ bottomLeft: 8, bottomRight: 8 })
  }

  //请求数据房源推荐信息
  async requestRoomInfoData() {
    let roomList = await httpUtil.get<RoomList>(Api.roomInfo)
    this.rDataSource.setList(roomList)
  }
}

@Extend(Text)
function textStyle(fontSize: number, fontColor: ResourceStr | Color) {
  .fontSize(fontSize)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
}

@Extend(Button)
function btnStyle(fontColor: ResourceStr | Color, bgColor: ResourceStr) {
  .height(18)
  .fontSize(10)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
  .type(ButtonType.Normal)
  .backgroundColor(bgColor)
  .padding({ left: 6, right: 6 })
  .borderRadius(2)
}
