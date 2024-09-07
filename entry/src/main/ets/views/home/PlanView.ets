import { PlanItem, PlanList } from '../../models/home/HomeModel'

@Component
export default struct PlanView {
  @Prop planList: PlanList

  build() {
    Grid() {
      ForEach(this.planList, (planItem: PlanItem) => {
        GridItem() {
          Image(planItem.imageURL)
        }
      }, (planItem: PlanItem) => planItem.id + '')
    }
    .width('100%')
    .height(300)
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(8)
    .scrollBar(BarState.Off)
  }
}