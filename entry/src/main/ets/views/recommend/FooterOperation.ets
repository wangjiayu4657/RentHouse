import { emitter } from '@kit.BasicServicesKit'

@Component
export default struct FooterOperation {
  build() {
    //操作按钮
    Row({space: 20}) {
      Button('重置')
        .btnStyle('#666', '#F0F0F0')
        .layoutWeight(1)
        .onClick(() => {
          emitter.emit('resetFilterCriteria')
        })

      Button('查看房源')
        .btnStyle('#fff', '#67C0A8')
        .layoutWeight(2)
        .onClick(() => {
          emitter.emit('searchRecommendRoom')
        })
    }
    .width('100%')
    .height(32)
    .backgroundColor('#F7F7F7')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Extend(Button) function btnStyle(fontColor:ResourceColor, bgColor:ResourceColor) {
  .type(ButtonType.Normal)
  .fontSize(14)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
  .borderRadius(4)
  .backgroundColor(bgColor)
}