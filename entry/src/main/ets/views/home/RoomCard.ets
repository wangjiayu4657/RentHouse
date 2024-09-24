import { RoomItem, TagItem } from '../../models/home/HomeModel'

@Component
export default struct RoomCard {
  @Prop roomItem:RoomItem

  @Builder topViewBuilder() { }
  @BuilderParam topViewParamBuilder: () => void = this.topViewBuilder

  build() {
    Column() {
      this.topViewParamBuilder()
      //房间图片
      this.roomPictureBuild()
      //房间信息
      this.roomInfoBuilder()
    }
    .width('100%')
    .height('100%')
  }

  //房间图片
  @Builder
  roomPictureBuild() {
    Stack() {
      //房间图片
      Image(this.roomItem.housePicture)
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

        Text(this.roomItem.address).textStyle(10, Color.White)
      }
      .margin({ left: 8, bottom: 8 })
    }
    .width('100%')
    .layoutWeight(1)
    .alignContent(Alignment.BottomStart)
  }

  //房间信息
  @Builder
  roomInfoBuilder() {
    Column({ space: 10 }) {
      //房间价格及面积
      Row() {
        Text(`${this.roomItem.rentPriceListing}${this.roomItem.rentPriceUnit}`).textStyle(14, '#E03810')
        Text(this.roomItem.rentArea + '㎡').textStyle(10, '#999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      //房间出租方式描述
      Text(this.roomItem.houseTitle)
        .textStyle(12, '#000')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      //房间优势描述
      Row({ space: 6 }) {
        ForEach(this.roomItem.tags.slice(0, 2), (tag: TagItem, idx: number) => {
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
    .padding(10)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .borderRadius({ bottomLeft: 8, bottomRight: 8 })
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