import { RoomItem, RoomList } from './HomeModel'

// @Observed
export class RecommendDataSource implements IDataSource {
  //数据源
  dataSource:RoomList = []
  //监听器数据源
  listenerList: DataChangeListener[] = []

  //获取数据源总数
  totalCount(): number {
    return this.dataSource.length
  }

  //获取单条数据
  getData(index: number): RoomItem {
    return this.dataSource[index]
  }

  //添加单条数据(自定义函数)
  setData(item:RoomItem) {
    if(this.dataSource.indexOf(item) < 0) {
      this.dataSource.push(item)
      this.notifyOnDataAdd(this.dataSource.length - 1)
    }
  }

  //更新全部数据(自定义函数)
  setList(list:RoomList) {
    this.dataSource = list
    this.notifyOnAllDataReload()
  }

  //注册数据改变的监听器
  registerDataChangeListener(listener: DataChangeListener): void {
    if(this.listenerList.indexOf(listener) < 0) {
      console.info('add listener');
      this.listenerList.push(listener)
    }
  }

  //注销数据改变的监听器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listenerList.indexOf(listener)
    if(pos >= 0) {
      console.info('remove listener');
      this.listenerList.splice(pos, 1)
    }
  }

  //添加数据时通知更新 UI
  notifyOnDataAdd(index:number) {
    this.listenerList.forEach((listener:DataChangeListener) => {
      listener.onDataAdd(index)
    })
  }

  //更新全部数据
  notifyOnAllDataReload() {
    this.listenerList.forEach((listener:DataChangeListener) => {
      listener.onDataReloaded()
    })
  }
}