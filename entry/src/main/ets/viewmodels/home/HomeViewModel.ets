import Api from '../../service/http/Api'
import { HomeModel } from '../../models/home/homeModel'
import httpUtil from '../../service/http/http'


class HomeViewModel {
  async requestHomeData() {
    let res = await httpUtil.get<HomeModel>(Api.homeInfo)
    console.log('res == ', JSON.stringify(res))
  }
}

const homeViewModel:HomeViewModel = new HomeViewModel()
export default homeViewModel as HomeViewModel