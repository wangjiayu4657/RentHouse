import FooterOperation from './FooterOperation'
import { emitter } from '@kit.BasicServicesKit'
import { RecommendParams } from '../../models/recommend/RecommendRoomModel'

//筛选条件 - 租金
@Component
export default struct FilterRent {
  @State selIdx: number = 0
  @State rentText: string = ''

  @Link param: RecommendParams

  util: string = ''       //单位
  minRent: string = ''    //最低租金
  maxRent: string = ''    //最高租金
  rents: string[] = ['不限', '1500以下', '1500-2500', '2500-3500', '3500-4500','4500-5500', '5500-6500', '6500-7500','7500-8500', '8500-10000', '10000以上']


  aboutToAppear(): void {
    this.getRent()

    //重置条件
    emitter.on('resetFilterCriteria', () => {
      this.util = ''
      this.rentText = ''
      this.param.minRent = undefined
      this.param.maxRent = undefined
      emitter.emit('resetFilter')
    })

    //查看房源
    emitter.on('searchRecommendRoom', () => {
      this.param.minRent = this.minRent
      this.param.maxRent = this.maxRent
      let tempRentText = this.rentText + this.util
      emitter.emit('searchFilter', { data: tempRentText })
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

        GridRow({gutter: 15, columns: 3}) {
          ForEach(this.rents, (item:string) => {
            GridCol() {
              Button(item, { type: ButtonType.Normal })
                .width('100%')
                .fontSize(12)
                .fontColor(this.rentText === item ? '#fff' : '#666')
                .fontWeight(FontWeight.Medium)
                .borderRadius(4)
                .backgroundColor(this.rentText === item ? '#67C0A8' : '#F7F7F7')
                .padding({ top: 4, bottom: 4})
                .onClick(() => {
                  this.handlerRentParam(item)
                })
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

  handlerRentParam(rent:string) {
    this.rentText = rent

    if(rent == '不限') {
      this.minRent = '0'
      this.maxRent = '0'
    } else if(rent === '1500以下') {
      this.minRent = '0'
      this.maxRent = '1500'
    } else if(rent === '10000以上') {
      this.minRent = '10000'
      this.maxRent = '0'
    } else {
      this.util = '元'
      let rents = rent.split('-')
      this.minRent = rents.length < 2 ? '' : rents[0]
      this.maxRent = rents.length < 2 ? '' : rents[1]
    }
  }

  getRent()  {
    if(this.param.minRent === '0' && this.param.maxRent === '0') {
      this.rentText = '不限'
      this.minRent = '0'
      this.maxRent = '0'
    } else if(this.param.minRent === '0' && this.param.maxRent === '1500') {
      this.minRent = '0'
      this.maxRent = '1500'
      this.rentText = '1500以下'
    } else if(this.param.minRent === '10000' && this.param.maxRent === '0') {
      this.minRent = '10000'
      this.maxRent = '0'
      this.rentText = '10000以上'
    } else {
      this.minRent = this.param.minRent ?? '0'
      this.maxRent = this.param.maxRent ?? '0'
      this.rentText = this.param.minRent + '-' + this.param.maxRent
    }
  }
}