interface recommendDailyType{
  img: string
  title: string
  type:string
  top:string
  bottom:string
}

interface recommendListType {
  img :string
  title: string
  count:string
}


@Component

//export导出，别的组件才可以去使用它
export struct Recommend {
  //轮播图数据
  swiperList: string[] = [
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
    'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png',
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
  ]

  //每日推荐的内容
  dailyRecommend: recommendDailyType[] =[
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
    title: '每日推荐 ｜ 今天从《不得不爱》听起 ｜ 私人雷达',
    type: '每日推荐',
    top: '#660000',
    bottom: '#382e2f'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend2.png',
    title: '从[Nothing on Me]开启无线漫游',
    type: '私人漫游',
    top: '#662200',
    bottom: '#384d2a'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend3.png',
    title: '每日必听-线性小狗带你走出emo时刻',
    type: '华语歌单',
    top: '#664400',
    bottom: '#383f2c'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend4.png',
    title: '时光代理人精选歌单',
    type: '华语歌单',
    top: '#664400',
    bottom: '#383f2c'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend4.png',
    title: '每日必听-线性小狗带你走出emo时刻',
    type: '华语歌单',
    top: '#664400',
    bottom: '#383f2c'
  }
]

  //推荐歌单数据
  recommendList:recommendListType[] =[
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 ｜ 今天从《不得不爱》听起 ｜ 私人雷达',
      count: '270.9万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 ｜ 今天从《不得不爱》听起 ｜ 私人雷达',
      count: '270.9万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 ｜ 今天从《不得不爱》听起 ｜ 私人雷达',
      count: '270.9万'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/recommend1.png',
      title: '每日推荐 ｜ 今天从《不得不爱》听起 ｜ 私人雷达',
      count: '270.9万'
    }
  ]


  @ Builder
  titleBuilder(name:string)
  {
    Row(){
      Text(name)
        .width('100%')
        .fontColor(Color.Black)
        .fontWeight(700)
        .layoutWeight(1);
      Image($r('app.media.image'))
        .width(22)
        .fillColor(Color.Black)
    }
    .width('100%')
    .height(50)
  }
  build() {
    Column({space:10}){
      List({space:5}){
        ListItem(){
          Row(){
            Image($r('app.media.ic_search'))
              .width(22)
              .fillColor('#817D83')
            TextInput({placeholder:'乌梅子酱'})
              .placeholderColor('#817D83')
              .padding({left:5})
              .fontColor('#999')
              .backgroundColor('#FFFFFF')
              .layoutWeight(1)
            Image($r('app.media.ic_code'))
              .width(20)
              .fillColor('#817D83')
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .border({radius:20})
          .padding({left:8,right:8})
        }
        .margin(5)
        ListItem(){
          Swiper(){
            ForEach(this.swiperList,(item:string)=>{
              Image(item)
                .width('100%')
            })
          }
          .autoPlay(true)
          .border({radius:10})
        }
        this.titleBuilder('每日推荐')
        ListItem(){
          // 每日推荐区域
          List(){
            ForEach(this.dailyRecommend,(item:recommendDailyType) =>{
              ListItem(){
                Column(){
                  Text(item.type)
                    .width('100%')
                    .height('15%')
                    .backgroundColor(item.top)
                    .padding({left:5})
                    .fontSize(14)
                    .fontColor('#fff')
                  Image(item.img)
                    .width('100%')
                  Text(item.title)
                    .width('100%')
                    .backgroundColor(item.bottom)
                    .padding(5)
                    .fontColor('#fff')
                    .maxLines(2)
                    .textOverflow({overflow:TextOverflow.Ellipsis})//两行之后提供省略号
                }
                .width('40%')
                // .height(200)
                // .backgroundColor(Color.Pink)
                .border({radius:10})
                .margin({right:10})
                .clip(true)
              }
            })
          }
          .listDirection((Axis.Horizontal))
          .height(230)//List组件占了很大的高度，因此需要给它一个高度
          .scrollBar(BarState.Off)
        }
        this.titleBuilder('推荐歌单')
        ListItem(){

          List()
          {
            ForEach(this.recommendList,(item:recommendListType)=>{
              ListItem(){
                Column(){
                  Stack({alignContent:Alignment.TopStart}){
                    Image(item.img)
                      .width('100%')
                      .height(100)
                      .border({radius:8})
                    Text(item.count)
                      .fontColor(('#fff'))
                      .fontSize(12)
                      .fontWeight(700)
                      .margin(5)
                  }
                  Text(item.title)
                    .fontColor('#fff')
                    .fontSize(14)
                    .width('100%')
                    .padding(5)
                    .maxLines(2)
                    .backgroundColor('#ffb1e7e3')
                    .textOverflow({overflow:TextOverflow.Ellipsis})
                }
                .width('30%')
                // .height(200)
                // .backgroundColor(Color.Pink)
                .margin({right:10})
              }
            })
          }
          .listDirection(Axis.Horizontal)
          .height(230)//List组件占了很大的高度，因此需要给它一个高度
          .scrollBar(BarState.Off)
        }
      }
      .scrollBar(BarState.Off)
      // Row(){
      //   Image($r('app.media.ic_search'))
      //     .width(22)
      //     .fillColor('#817D83')
      //   TextInput({placeholder:'乌梅子酱'})
      //     .placeholderColor('#817D83')
      //     .padding({left:5})
      //     .fontColor('#999')
      //     .backgroundColor('#FFFFFF')
      //     .layoutWeight(1)
      //   Image($r('app.media.ic_code'))
      //     .width(20)
      //     .fillColor('#817D83')
      // }
      // .width('100%')
      // .backgroundColor('#FFFFFF')
      // .border({radius:20})
      // .padding({left:8,right:8})
      // //轮播图区域
      // Swiper(){
      //   ForEach(this.swiperList,(item:string)=>{
      //     Image(item)
      //       .width('100%')
      //   })
      // }
      // .autoPlay(true)
      // .border({radius:10})
      // // 每日推荐区域
      // this.titleBuilder('每日推荐')
      // List(){
      //   ForEach(this.dailyRecommend,(item:recommendDailyType) =>{
      //     ListItem(){
      //       Column(){
      //         Text(item.type)
      //           .width('100%')
      //           .height('15%')
      //           .backgroundColor(item.top)
      //           .padding({left:5})
      //           .fontSize(14)
      //           .fontColor('#fff')
      //         Image(item.img)
      //           .width('100%')
      //         Text(item.title)
      //           .width('100%')
      //           .backgroundColor(item.bottom)
      //           .padding(5)
      //           .fontColor('#fff')
      //           .maxLines(2)
      //           .textOverflow({overflow:TextOverflow.Ellipsis})//两行之后提供省略号
      //       }
      //       .width('40%')
      //       // .height(200)
      //       // .backgroundColor(Color.Pink)
      //       .border({radius:10})
      //       .margin({right:10})
      //       .clip(true)
      //     }
      //   })
      // }
      // .listDirection((Axis.Horizontal))
      // .height(230)//List组件占了很大的高度，因此需要给它一个高度
      // .scrollBar(BarState.Off)
      // // 推荐歌单数据
      // this.titleBuilder('推荐歌单')
      // List()
      // {
      //   ForEach(this.recommendList,(item:recommendListType)=>{
      //     ListItem(){
      //       Column(){
      //         Stack({alignContent:Alignment.TopStart}){
      //           Image(item.img)
      //             .width('100%')
      //             .height(100)
      //             .border({radius:8})
      //           Text(item.count)
      //             .fontColor(('#fff'))
      //             .fontSize(12)
      //             .fontWeight(700)
      //             .margin(5)
      //         }
      //         Text(item.title)
      //           .fontColor('#fff')
      //           .fontSize(14)
      //           .width('100%')
      //           .padding(5)
      //           .maxLines(2)
      //           .textOverflow({overflow:TextOverflow.Ellipsis})
      //       }
      //       .width('30%')
      //       .height(200)
      //       .backgroundColor(Color.Pink)
      //       .margin({right:10})
      //     }
      //   })
      // }
      // .listDirection(Axis.Horizontal)
    }
      .width('100%')
      .height('100%')
      .padding({left:10, right:10, top:5,bottom:5})

  }
}