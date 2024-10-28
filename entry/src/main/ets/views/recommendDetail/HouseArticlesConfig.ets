import { HouseholdItem, HouseholdList, RoomItem } from "../../models/recommend/RecommendRoomDetailModel"

//房屋物品配置
@Component
export struct HouseArticlesConfig {
  @Prop holdList: HouseholdList

  build() {
    Column({space: 15}) {
      Text('物品配置').fontSize(18).fontColor('#000').fontWeight(FontWeight.Bold).margin({ bottom: 8 })
      this.householdListBuilder()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  householdListBuilder() {
    Flex({direction: FlexDirection.Column, alignItems: ItemAlign.Stretch}) {
      List({space: 20}) {
        ForEach(this.holdList, (item: HouseholdItem) => {
          ListItem() {
            this.articlesGroupBuilder(item)
          }
        }, (item: HouseholdItem) => item.name)
      }
      .width('100%')
      .height('auto')
    }
  }

  @Builder
  articlesGroupBuilder($: HouseholdItem) {
    Column() {
      Row({ space: 4 }) {
        Text($.name).fontSize(14).fontColor('#000').fontWeight(FontWeight.Bold)
        Text(`${$.itemList.length}件物品`).fontSize(10).fontColor('#999').fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ bottom: 15 })
      .justifyContent(FlexAlign.Start)

      GridRow({ columns: 3, gutter: { y: 10 } }) {
        ForEach($.itemList, (item: RoomItem) => {
          GridCol() {
            Row({ space: 4 }) {
              Image(item.icon).width(16).aspectRatio(1).fillColor('#666')
              Text(item.value).fontSize(14).fontColor('#666').fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
        }, (item: RoomItem) => item.value)
      }
    }
  }
}