import FooterOperation from './FooterOperation'
import { emitter } from '@kit.BasicServicesKit'
import { RecommendParams } from '../../models/recommend/RecommendRoomModel'

@Component
export default struct FilterPayment {
  @State selIdx:number = 0
  @Link param:RecommendParams

  @State payWay: string = ''
  payWays: string[] = ['月付', '季付', '半年付', '年付']

  aboutToAppear(): void {
    this.payWay = this.param.paymentTyp ?? ''

    //重置条件
    emitter.on('resetFilterCriteria',() => {
      emitter.emit('resetFilter')
    })

    //查看房源
    emitter.on('searchRecommendRoom', () => {
      this.param.paymentTyp = this.payWay
      emitter.emit('searchFilter')
    })
  }

  aboutToDisappear(): void {
    emitter.off('resetFilterCriteria')
    emitter.off('searchRecommendRoom')
  }

  build() {
    Column() {
      Column({space: 15}) {
        Text('支付方式')
          .fontSize(12)
          .fontColor('#000')
          .fontWeight(FontWeight.Bold)
          .padding({ top: 10, left: 15 })

        Row({space: 15}) {
          ForEach(this.payWays, (item:string) => {
            Button(item, {type: ButtonType.Normal})
              .fontSize(12)
              .fontColor(this.payWay === item ? '#fff' : '#666')
              .fontWeight(FontWeight.Medium)
              .borderRadius(4)
              .backgroundColor(this.payWay === item  ? '#67C0A8' : '#F7F7F7')
              .padding({top: 4, left: 16, bottom: 4, right: 16})
              .onClick(() => this.payWay = item)
          })
        }
        .width('100%')
        .height(26)
        .padding({left: 15, right: 15})
        .justifyContent(FlexAlign.SpaceBetween)

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