import { SongCard } from '../constants/MineData'

interface songItemType {
  img: string
  name: string
  author: string
  url: string
  id: string
}

class songItemTypeModel implements songItemType {
  img: string = ''
  name: string = ''
  author: string = ''
  url: string = ''
  id: string = ''

  constructor(model: songItemType) {
    this.img = model.img
    this.name = model.name
    this.author = model.author
    this.url = model.url
    this.id = model.id
  }
}

@Entry
@Component
export struct Mine {
  columnList: number[] = [0, 1, 2, 3]

  build() {
    Column() {
      //背景
      Column() {
        GridRow({ gutter: 8 }) {
          ForEach(this.columnList, (item: number, index: number) => {
            GridCol({ span: 3 }) {
              SongCard({ columnIndex: item })
            }
          })
        }
      }
      .scale({
        x: 1.15,
        y: 1.15,
        centerX: '50%',
        centerY: '0'
      })
      .height('75%')
      .width('100%')
      .backgroundColor('#000')

      //个人信息
      Column() {
        Column() {
          Image($r('app.media.logo1'))
            .width('90%')
        }
        .backgroundColor(Color.Black)
        .width(80)
        .aspectRatio(1)
        .borderRadius(80)
        .offset({ y: -40 })

        Column({ space: 12 }) {
          Row({ space: 8 }) {
            Text('线性小狗爱听音乐')
              .fontColor(Color.White)
              .fontSize(20)
            Image($r('app.media.ic_vip'))
              .width(40)
          }
          .offset({ y: -15 })

          Row() {
            Image($r('app.media.ic_boy'))
              .width(14)
              .fillColor('#ff23496b')
              .margin({ right: 4 })
            Text('00后')
              .fontColor('#555')
              .margin({ right: 4 })
            Text('双子座')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('北京')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('歌龄-18年')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }

          Row() {
            Text('1 关注')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('100万 分数')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('1 关注')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('100万 粉丝')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('1.67亿点赞')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }
        }
      }
      .width('100%')
      .height('25%')
      .backgroundColor('#121215')
    }
    .width('100%')
  }
}
