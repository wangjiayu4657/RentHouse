
type ICallBack = (arg?: unknown) => unknown
type IEventList = ICallBack[]

//自定义事件接口
interface IEvents {
  [key: string] : IEventList
}

 class EmitterUtil {
  //自定义事件
  events:IEvents = {}

  //绑定自定义事件
  on(eventName:string, callBack:ICallBack) {
    if(!eventName) return
    if(this.events[eventName]) {
      this.events[eventName].push(callBack)
    } else {
      this.events[eventName] = [callBack]
    }
  }

  //解绑自定义事件
  off(eventName:string, callBack?:ICallBack) {
    if(!eventName) return
    let eventList = this.events[eventName]
    if(callBack) {
      this.events[eventName] = eventList.filter((cb: ICallBack) => cb !== callBack)
    } else {
      delete this.events[eventName]
    }
  }

  //发送自定义事件
  emit(eventName:string, arg?: unknown) {
    if(!eventName) return
    let eventList = this.events[eventName]
    eventList?.forEach((callBack:ICallBack) => callBack(arg))
  }
}

const emitterUtil:EmitterUtil = new EmitterUtil()
export default emitterUtil as EmitterUtil