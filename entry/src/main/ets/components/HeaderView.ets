import VerticalItem from './VerticalItem'

@Component
export struct HeaderView {
  // @Builder leadBuilder() {}
  // @BuilderParam leadParamBuilder: () => void = this.leadBuilder
  //
  // @Builder tailBuilder() {}
  // @BuilderParam tailParamBuilder: () => void = this.tailBuilder

  build() {
    Row() {
      Row({ space: 8 }) {
        Image($r('app.media.bag'))
          .id('bagIconId')
          .width(16)

        Text('填写通勤地址')
          .id('addressId')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }

      Row({ space: 28 }) {
        VerticalItem({img: $r('app.media.message'), name: '消息'})
        VerticalItem({img: $r('app.media.journey'), name: '行程'})
      }
    }
    .width('100%')
    .padding({ left: 15, right: 15 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}