import { Discover } from './Discover';
import { Home } from './Home';
import { Profile } from './Profile';
import { Service } from './Service';
import { ToSee } from './ToSee';

@Entry
@Component
struct Index {
  @State curIdx: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }.tabBar(this.tabItemBuilder('app.media.tabbar_home', '首页', 0))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      TabContent() {
        ToSee()
      }.tabBar(this.tabItemBuilder('app.media.tabbar_see', '想看', 1))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      TabContent() {
        Service()
      }.tabBar(this.tabItemBuilder('app.media.tabbar_service', '服务', 2))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      TabContent() {
        Discover()
      }.tabBar(this.tabItemBuilder('app.media.tabbar_discover', '发现', 3))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      TabContent() {
        Profile()
      }.tabBar(this.tabItemBuilder('app.media.tabbar_my', '我的', 4))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .width('100%')
    .height('100%')
    .scrollable(false)
    .animationDuration(0)
    .padding({ bottom: 20 })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .onChange((idx: number) => {
      this.curIdx = idx
    })
  }

  //自定义 tabBar
  @Builder
  tabItemBuilder(icon: string, text: string, idx: number) {
    Column() {
      //图标
      Image(this.curIdx == idx ? $r(`${icon}_active`) : $r(icon))
        .width(28)
        .aspectRatio(1)

      //名称
      Text(text)
        .fontSize(10)
        .fontColor(this.curIdx == idx ? $r('app.color.primary') : $r('app.color.gray'))
    }
  }
}