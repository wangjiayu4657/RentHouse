import VerticalItem from '../../components/VerticalItem'
import { VipServiceItem, VipServiceList } from '../../models/service/ServiceModel'

@Component
export default struct ServiceHeader {
  @StorageProp('statusBarHeight') statusBarHeight:number = 0
  @Prop vipServiceList: VipServiceList

  build() {
    Stack() {
      //背景图
      Image($r('app.media.service_bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)

      Column() {
        //头部组件
        this.headerBuilder()

        //vip 内容组件
        this.vipBuilder()

        //向下箭头图标
        Image($r('app.media.arrow_up_reverse'))
          .width(20)
          .aspectRatio(1)
          .fillColor(Color.White)
          .padding({ bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Top)
  }

  //头部组件
  @Builder
  headerBuilder() {
    Row() {
      Row({ space: 6 }) {
        Text('请选择地址')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)

        Image($r('app.media.arrow_down'))
          .width(12)
          .objectFit(ImageFit.Contain)
          .padding({ bottom: 4 })
      }

      Row({ space: 28 }) {
        VerticalItem({
          img: $r('app.media.message'),
          imgColor: Color.White,
          name: '消息',
          fontColor: Color.White
        })
        VerticalItem({
          img: $r('app.media.journey'),
          imgColor: Color.White,
          name: '客服',
          fontColor: Color.White
        })
      }
    }
    .width('100%')
    .padding({top: this.statusBarHeight})
    .justifyContent(FlexAlign.SpaceBetween)
  }

  //vip 内容组件
  @Builder
  vipBuilder() {
    Stack() {
      //vip 背景图片
      Image($r('app.media.vip_bg'))
        .width('100%')

      Column() {
        //vip 头部视图
        this.vipHeaderBuilder()
        //vip 内容视图
        this.vipBodyBuilder()
      }
      .width('100%')
      .height(100)
    }
  }

  //vip 头部
  @Builder
  vipHeaderBuilder() {
    Row() {
      Image($r('app.media.crown'))
        .width(18)
        .aspectRatio(1)

      Text('开通谷粒卡享特权')
        .fontSize(16)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })

      Blank()

      Image($r('app.media.vip'))
        .width(42)
        .objectFit(ImageFit.Contain)
    }
    .width('75%')
    .margin({ top: 10 })
  }

  //vip 内容
  @Builder
  vipBodyBuilder() {
    Row() {
      ForEach(this.vipServiceList, (item:VipServiceItem, idx:number) => {
        this.vipItemBuilder(item.name, item.content, ['元', '张', '项', '个'][idx])
      })
    }
    .width('75%')
    .margin({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  //vip item
  @Builder
  vipItemBuilder(name: string, num: number, unit: string) {
    Column({ space: 6 }) {
      Text(name)
        .fontSize(12)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Medium)

      Text() {
        Span(num + '')
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)

        Span(unit)
          .fontSize(10)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
      }
    }
  }
}