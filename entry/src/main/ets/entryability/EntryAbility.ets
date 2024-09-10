import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    //获取主要 window
    const mainWindow = await windowStage.getMainWindow()
    mainWindow.setWindowLayoutFullScreen(true)

    //获取有效区域
    let avoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    //获取状态栏的高度
    const statusBarHeight = avoidArea.topRect.height
    AppStorage.setOrCreate('statusBarHeight', px2vp(statusBarHeight))

    //获取导航栏的高度
    avoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
    const navigationBarHeight = avoidArea.bottomRect.height
    AppStorage.setOrCreate('navigationBarHeight', px2vp(navigationBarHeight))

    //获取安全区域底部的距离
    const safeAreaBottomHeight = avoidArea.bottomRect.height
    AppStorage.setOrCreate('safeAreaBottomHeight', px2vp(safeAreaBottomHeight))

    console.log('area === ', JSON.stringify(avoidArea))
    const area1 = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    console.log('area1 === ', JSON.stringify(area1))

    mainWindow.setWindowSystemBarProperties({
      statusBarContentColor: '#ffffff'
    })
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
