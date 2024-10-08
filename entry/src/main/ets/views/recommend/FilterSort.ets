import { emitter } from '@kit.BasicServicesKit'
import { RecommendParams } from '../../models/recommend/RecommendRoomModel'

//筛选条件 - 排序
@Component
export default struct FilterSort {
  @Link param:RecommendParams

  desc: string = ''  //排序描述
  filterIcons: string[] = ['recommend_sort', 'recommend_price', 'recommend_price', 'recommend_area', 'recommend_area']
  filterNames: string[] = [ '综合排序', '价格从低到高', '价格从高到低','面积从小到大','面积从大到小']


  aboutToAppear(): void {
    this.handlerSelOrder()
  }

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
        .fillColor(this.handlerSelColor(item))
        .objectFit(ImageFit.Contain)

      Text(item)
        .fontSize(12)
        .fontColor(this.handlerSelColor(item))
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(34)
    .padding({ left: 15, right: 15 })
    .onClick(() => {
      this.desc = item
      this.startOrder(idx)
    })
  }

  //开始排序
  startOrder(idx:number) {
    if(idx == 0) {
      this.param.orderBy = ''
      this.param.orderType = ''
    } else if(idx == 1) {
      this.param.orderBy = 'price'
      this.param.orderType = 'asc'
    } else if(idx == 2) {
      this.param.orderBy = 'price'
      this.param.orderType = 'desc'
    } else if(idx == 3) {
      this.param.orderBy = 'area'
      this.param.orderType = 'asc'
    } else {
      this.param.orderBy = 'area'
      this.param.orderType = 'desc'
    }

    //发送排序参数, 请求接口
    emitter.emit('searchFilter', { data: this.desc })
  }

  //处理选中的颜色
  handlerSelColor(item:string) : ResourceColor {
    return this.desc === item ? '#67C0A8' : '#666'
  }

  //处理选中的排序条件
  handlerSelOrder() {
    if (this.param.orderBy == '' && this.param.orderType == '') {
      this.desc = this.filterNames[0]
    } else if(this.param.orderBy == 'price' && this.param.orderType == 'asc') {
      this.desc = this.filterNames[1]
    } else if(this.param.orderBy == 'price' && this.param.orderType == 'desc') {
      this.desc = this.filterNames[2]
    } else if(this.param.orderBy == 'area' && this.param.orderType == 'asc') {
      this.desc = this.filterNames[3]
    } else {
      this.desc = this.filterNames[4]
    }
  }
}