import Api from '../../service/http/Api'
import { HomeModel } from '../../models/home/HomeModel'
import httpUtil from '../../service/http/HttpUtil'


class HomeViewModel {
  async requestHomeData() {
    let res = await httpUtil.get<HomeModel>(Api.homeInfo)
    console.log('res == ', JSON.stringify(res))
  }
}

const homeViewModel:HomeViewModel = new HomeViewModel()
export default homeViewModel as HomeViewModel