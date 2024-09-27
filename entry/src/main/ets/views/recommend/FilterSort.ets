import { RecommendParams } from '../../models/recommend/RecommendRoomModel'
import { emitter } from '@kit.BasicServicesKit'

//筛选条件 - 排序
@Component
export default struct FilterSort {
  @Link param:RecommendParams
  filterIcons: string[] = ['recommend_sort', 'recommend_price', 'recommend_price', 'recommend_area', 'recommend_area']
  filterNames: string[] = [ '综合排序', '价格从低到高', '价格从高到低','面积从大到小','面积从小到大' ]

  build() {
    Column() {
      List() {
        ForEach(this.filterNames, (item: string, idx:number) => {
          ListItem() {
            this.listItemBuilder(item, idx)
          }
        }, (item: string) => item)
      }
      .width('100%')
      .height(194)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#b3000000')
    .onClick(() => emitter.emit('emptyClick'))
  }

  @Builder
  listItemBuilder(item:string, idx:number) {
    Row({space: 8}) {
      Image($r(`app.media.${this.filterIcons[idx]}`))
        .width(16)
        .fillColor('#666')
        .objectFit(ImageFit.Contain)

      Text(item)
        .fontSize(12)
        .fontColor('#666')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(34)
    .padding({ left: 15, right: 15 })
    .onClick(() => emitter.emit('searchFilter'))
  }
}