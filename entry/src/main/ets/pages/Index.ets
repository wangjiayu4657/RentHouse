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
    Tabs({barPosition: BarPosition.End}) {
      TabContent() {
        Home()
      }.tabBar(this.tabBarBuilder('app.media.tabbar_home', '首页', 0))

      TabContent() {
        ToSee()
      }.tabBar(this.tabBarBuilder('app.media.tabbar_see', '想看', 1))

      TabContent() {
        Service()
      }.tabBar(this.tabBarBuilder('app.media.tabbar_service', '服务', 2))

      TabContent() {
        Discover()
      }.tabBar(this.tabBarBuilder('app.media.tabbar_discover', '发现', 3))

      TabContent() {
        Profile()
      }.tabBar(this.tabBarBuilder('app.media.tabbar_my', '我的', 4))
    }
    .height('100%')
    .width('100%')
    .scrollable(false)
    .onChange((idx: number) => {
      this.curIdx = idx
    })
  }

  //自定义 tabBar
  @Builder
  tabBarBuilder(icon: string, text: string, idx: number) {
    Column() {
      //图标
      Image(this.curIdx == idx ? $r(`${icon}_active`) : $r(icon))
        .width(28)
        .aspectRatio(1)

      //名称
      Text(text)
        .fontSize(10)
        .fontColor(this.curIdx == idx ? $r('app.color.black') : $r('app.color.gray'))
    }
  }
}