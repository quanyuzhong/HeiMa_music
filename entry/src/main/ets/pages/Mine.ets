@Component
  //export导出，别的组件才可以去使用它
export struct Mine {
  build() {
    Text('我的')
  }
}