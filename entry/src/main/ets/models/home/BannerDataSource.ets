import { BannerItem, BannerList } from './HomeModel';

@Observed
export class BannerDataSource implements IDataSource {
  //数据源
  bannerList: BannerList = [];
  //数据变化监听器,内部用来触发UI更新对象
  listeners: DataChangeListener[] = [];

  //返回数据总长度
  public totalCount(): number {
    return this.bannerList.length;
  }

  //保存单条数据
  public setData(bannerItem:BannerItem) {
    //只更新数据,但不会刷新 UI
    this.bannerList.push(bannerItem)
    //触发 UI 更新
    this.notifyDataAdd(this.bannerList.length - 1)
  }

  //保存所有数据
  public setList(list: BannerList) {
    if(list.length === 0 || list === null) return
    //保存列表数据
    this.bannerList = list
    //刷新所有数据
    this.notifyDataReload()
  }

  //读取对应下标的数据
  public getData(index: number): BannerItem {
    return this.bannerList[index];
  }

  //注册数据改变的监听器. 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  //注销数据改变的监听器. 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

