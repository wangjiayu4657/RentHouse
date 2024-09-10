import { window } from '@kit.ArkUI'

@Component
export struct ScrollContainer {
  //获取安全区域顶部的距离
  @StorageProp('statusBarHeight') statusBarHeight: number = 0
  //滚动组件
  scroller: Scroller = new Scroller()
  //字体颜色
  @State fontColor: ResourceStr | Color = Color.White
  //导航栏的背景颜色
  @State bgColor: ResourceStr | Color = Color.Transparent

  //外部传入的导航组件
  @Builder navBuilder() { }
  @BuilderParam navParamBuilder: ($:NavInfo) => void = this.navBuilder

  //外部传入的内容组件
  @Builder bodyBuilder() { }
  @BuilderParam bodyParamBuilder: () => void = this.bodyBuilder

  //获取 window 对象
  mainWindow = window.getLastWindow(getContext(this))


  build() {
    Stack() {
      //滚动画布
      this.scrollBuilder()
      //导航栏
      this.navigationBarBuilder()
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Top)
  }

  //导航栏组件
  @Builder
  navigationBarBuilder() {
    Column() {
      this.navParamBuilder({ fontColor: this.fontColor })
    }
    .padding({top: this.statusBarHeight})
    .backgroundColor(this.bgColor)
  }

  //构建画布
  @Builder
  scrollBuilder() {
    //滚动画布
    Scroll(this.scroller) {
      this.bodyParamBuilder()
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
    .padding({ bottom: 10 })
    .edgeEffect(EdgeEffect.Spring)
    .onDidScroll(() => {
      const off = this.scroller.currentOffset()
      this.handlerBgColor(off.yOffset)
    })
  }

  //处理渐变颜色, 0 ~ 94 渐变
  handlerBgColor(offY: number) {
    //滑动差值
    if (offY <= 0) {
      this.fontColor = Color.White
      this.bgColor = Color.Transparent
      this.changeStatusBarColor('#ffffff')
    } else if (offY >= 94) {
      this.fontColor = Color.Black
      this.bgColor = Color.White
      this.changeStatusBarColor('#000000')
    } else { // 0 ~ 94 之间按比例计算显示
      //滑动比例
      const ratio = offY / 94
      this.fontColor = `rgba(255,255,255,${ratio})`
      this.bgColor = `rgba(255,255,255,${ratio})`
      this.changeStatusBarColor('#999999')
    }
  }

  //改变状态栏的颜色
  changeStatusBarColor(barColor: string) {
    this.mainWindow.then((window: window.Window) => {
      window.setWindowSystemBarProperties({
        statusBarContentColor: barColor
      })
    })
  }
}

//导航栏信息
export interface NavInfo {
  //导航栏中字体及图标的颜色
  fontColor: ResourceStr | Color
}