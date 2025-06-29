//导入
import { Find } from "./Find";
import { Mine } from "./Mine";
import { Moment } from "./Moment";
import { Recommend } from "./Recommand";

interface TabClass {
  text: string
  icon: ResourceStr
}




// 跳转页面入口函数
@Builder
export function LayoutBuilder() {
  Layout()
}

@ComponentV2
struct Layout {
  //控制跳转的对象
  @Local currentIndex:number = 0
  pathStack: NavPathStack = new NavPathStack();
  tabData: TabClass[] =[
    {text: '推荐', icon: $r('app.media.xg1')},
    {text: '发现', icon: $r('app.media.xg2')},
    {text: '动态', icon: $r('app.media.xg3')},
    {text: '我的', icon: $r('app.media.xg4')}
  ]
  @Builder tabBuilder(item: TabClass,index:number) {
    Column({space:5}){
      Image(item.icon)
        .width(40)
        .fillColor(this.currentIndex == index ? Color.Black :Color.Gray)
      Text(item.text)
        .fontColor(this.currentIndex == index ? Color.Black :Color.Gray);
    }


  }
  build() {
    NavDestination() {
      Tabs({barPosition:BarPosition.End})
      {
        ForEach(this.tabData,(item:TabClass,index:number)=>{
          TabContent(){//只能有唯一的子组件
            if(this.currentIndex == 0){
              Recommend()
            }
            else if(this.currentIndex == 1)
            {
              Find()
            }
            else if(this.currentIndex == 2)
            {
              Moment()
            }
            else if(this.currentIndex == 3)
            {
              Mine()
            }
          }
          .tabBar(this.tabBuilder(item, index)) //自定义导航栏-> @Builder
          .backgroundColor('#F6F6F6')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        })

      }
      .onChange((index:number) => {
        this.currentIndex = index
      })
      .barHeight(70)
      .backgroundColor('#FFFFFE')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

    }
    // .title('布局页')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}
