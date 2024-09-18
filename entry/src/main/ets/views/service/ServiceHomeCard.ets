import VerticalItem from '../../components/VerticalItem'
import { HomeServiceItem, HomeServiceList } from '../../models/service/ServiceModel'
import ServiceCardHeader from './ServiceCardHeader'

//家庭服务组件
@Component
export struct ServiceHomeCard {
  @Prop homeServiceList: HomeServiceList = []

  build() {
    Column() {
      //卡片头部组件
      ServiceCardHeader({ leadTitle: '家庭服务', tailTitle: '全部服务' })
        .width('100%')
        .padding(12)

      //卡片内容组件
      this.serviceCardBody()
    }
    .width('100%')
  }

  @Builder
  serviceCardBody() {
    Grid() {
      ForEach(this.homeServiceList, (item: HomeServiceItem) => {
        GridItem() {
          VerticalItem({
            img: item.icon,
            iconSize: 24,
            name: item.title,
            fontSize: 12,
            verticalSpace: 8,
          })
        }
      }, (item: HomeServiceItem) => item.title)
    }
    .width('100%')
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
    .rowsGap(22)
    .padding({bottom: 15})
  }
}