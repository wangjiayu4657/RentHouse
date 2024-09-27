import FooterOperation from './FooterOperation'
import { emitter } from '@kit.BasicServicesKit'
import { RecommendParams } from '../../models/recommend/RecommendRoomModel'

//筛选条件 - 租金
@Component
export default struct FilterRent {
  @State minRent: string = ''
  @State maxRent: string = ''
  @State selIdx: number = 0
  @Link param: RecommendParams

  rents: string[] = ['不限', '1500元以下', '1500-2000元', '2000-2500元', '2500-3000元','3000-4000元', '4000-5000元', '5000-6000元','6000-7000元', '7000-8000元', '8000-15000元']

  aboutToAppear(): void {
    this.minRent = this.param.minRent ?? ''
    this.maxRent = this.param.maxRent ?? ''

    //重置条件
    emitter.on('resetFilterCriteria', () => {
      emitter.emit('resetFilter')
    })

    //查看房源
    emitter.on('searchRecommendRoom', () => {
      this.param.minRent = this.minRent
      this.param.maxRent = this.maxRent
      emitter.emit('searchFilter')
    })
  }

  aboutToDisappear(): void {
    emitter.off('resetFilterCriteria')
    emitter.off('searchRecommendRoom')
  }

  build() {
    Column() {
      Column({ space: 15 }) {
        Text('支付方式')
          .fontSize(12)
          .fontColor('#000')
          .fontWeight(FontWeight.Bold)
          .padding({ top: 10, left: 15 })


        GridRow({gutter: 15, columns: {
          sm: 3,
          md: 3,
          lg: 4,
          xl: 6,
          xxl: 6
        }}) {
          ForEach(this.rents, (item:string) => {
            GridCol() {
              Button(item, { type: ButtonType.Normal })
                .width('100%')
                .fontSize(12)
                .fontColor(this.minRent === item ? '#fff' : '#666')
                .fontWeight(FontWeight.Medium)
                .borderRadius(4)
                .backgroundColor(this.minRent === item ? '#67C0A8' : '#F7F7F7')
                .padding({ top: 4, bottom: 4})
            }
            .height(36)
          },(item:string) => item)
        }
        .width('100%')
        .height(185)
        .padding({ left: 15, right: 15 })


        //底部操作组件(重置, 查看房源)
        FooterOperation()
          .width('100%')
          .padding(15)
      }
      .width('100%')
      .backgroundColor('#fff')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#b3000000')
    .onClick(() => emitter.emit('emptyClick'))
  }
}