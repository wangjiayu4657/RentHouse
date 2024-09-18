@Component
export default struct VerticalItem {
  //图标
  img: ResourceStr = ''
  //名称
  name: ResourceStr = ''
  //字体大小
  fontSize: number = 10
  //字体样式
  fontWight: FontWeight = FontWeight.Medium
  //图标大小
  iconSize: number = 20
  //图标颜色
  imgColor: ResourceStr | Color = Color.Black
  //字体颜色
  fontColor: ResourceStr | Color = Color.Black
  //垂直间距(图标和标题之间的间距)
  verticalSpace: number = 4

  build() {
    Column({ space: this.verticalSpace }) {
      Image(this.img)
        .width(this.iconSize)
        .fillColor(this.imgColor)

      Text(this.name)
        .fontSize(this.fontSize)
        .fontColor(this.fontColor)
        .fontWeight(this.fontWight)
    }
  }
}