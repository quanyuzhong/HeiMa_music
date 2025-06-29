// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {//Start页面一打开开始计时三秒
  //控制跳转的对象
  pathStack: NavPathStack = new NavPathStack();
  //过3秒钟自动跳转Layout ->start页面打开计时3秒后打开
  aboutToAppear(): void {//生命周期
    setTimeout(()=>{
      this.pathStack.replacePathByName("Layout",null,false);//不支持返回
    },3000)//毫秒为单位
  }

  build() {
    NavDestination() {
      // Button('点击跳转到布局页')
      //   .onClick(()=>{
      //     this.pathStack.pushPathByName('Layout', null, false);
      //   })
      Stack({alignContent:Alignment.TopEnd}){
        Image($r('app.media.ad'))
          .width('100%')
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        Button('跳过')
          .backgroundColor(Color.Gray)
          .margin(15)
          .onClick(()=>{
            this.pathStack.replacePathByName("Layout",null,false)//不支持返回
            // this.pathStack.pushPathByName("Layout",null,false)//支持返回
          })
      }

    }
    // .title('广告页')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}
