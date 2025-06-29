import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../models/globalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { sessionManager } from './AvSessionmanager'

class AvPlayerManager{
  //属性 + 方法
  //播放器
  player :media.AVPlayer | null = null

  //共享播放数据
  currentSong :GlobalMusic = AppStorageV2.connect(GlobalMusic,'SONG_KEY',()=>new GlobalMusic())!

  //定义一个方法：创建播放器 + 坚挺播放器的状态
  async init() {
    if(!this.player){
      this.player = await media.createAVPlayer()
    }

    this.player.on('stateChange', (state) => {
      if(state=='initialized'){
        this.player?.prepare()
      }
      else if(state == 'prepared'){
        this.player?.play()
        this.currentSong.isPlay = true
      } else if(state =='completed')
      {
        this.nextPlay(true)
      }else if(state =='released')
      {
        this.currentSong.reset()
      }
    })

    //时间变化
    this.player.on('durationUpdate',(duration)=> {
      this.currentSong.duration = duration
      sessionManager.setAVMetadata(this.currentSong.playList[this.currentSong.playIndex])
    })
    this.player.on('timeUpdate',(time) => {
      this.currentSong.time = time
      sessionManager.setAVPlaybackState()
    })
  }
  //播放歌曲 -> 设置播放资源
  // singPlay(song:SongItemType) {
  //   this.player!.url = song.url
  //   this.currentSong.img = song.img
  // }

  singPlay(song:SongItemType){
    sessionManager.startBackgroundTask()
    sessionManager.setAVPlaybackState()
    //判断是否在列表 -> some 检查数组里面的数据是否满足条件 -> 只要有一个满足 same 返回 true
   const inList=  this.currentSong.playList.some(item => item.id == song.id)
    if (inList)
    {
      //在列表里面 -> 是否是正在播放的 ->currentSong url === song.url
      if(this.currentSong.url == song.url){
        this.player?.play()
        this.currentSong.isPlay = true
      } else {
        //设置新的索引 -> 切歌
        this.currentSong.playIndex = this.currentSong.playList.findIndex(item => item.id == song.id)

        //切歌
        this.changeSong()

      }
    }else {
      //不在列表里面-> 添加到列表->切换歌曲
      this.currentSong.playList.unshift(song)
      this.currentSong.playIndex = 0
      //切换歌曲
      this.changeSong()
    }
  }


  //切换歌曲 -> 充值播放器
  async changeSong(){
    await this.player?.reset()
    this.currentSong.duration = 0
    this.currentSong.time =0
    this.currentSong.img = this.currentSong.playList[this.currentSong.playIndex].img
    this.currentSong.name = this.currentSong.playList[this.currentSong.playIndex].name
    this.currentSong.author = this.currentSong.playList[this.currentSong.playIndex].author
    this.currentSong.url = this.currentSong.playList[this.currentSong.playIndex].url
    this.player!.url = this.currentSong.url
  }

  //跳转进度 seek
  seekPlay(value:number)
  {
    this.player?.seek(value)
  }


  //暂停
  paused() {
    this.player?.pause()
    this.currentSong.isPlay = false
    sessionManager.setAVPlaybackState()
  }

  //上一首
  prevPlay(){
    if (this.currentSong.playMode =='random') {
      //随机
      this.currentSong.playIndex =Math.floor(Math.random() * this.currentSong.playList.length)
    } else {
      this.currentSong.playIndex--
      if(this.currentSong.playIndex<0){
        //去最后一首
        this.currentSong.playIndex = this.currentSong.playList.length -1
      }
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  //下一首：根据播放模式计算索引 播放 -> if
  //真的重复播放 -> 播放模式为 repeat 并且 播放器自动下一首
  //随机 -> 计算随机索引
  //列表 -> ++
  nextPlay(autoNextPlay?: boolean){
    if (this.currentSong.playMode == 'repeat' && autoNextPlay  ) {
      //真的重复
      this.currentSong.playIndex = this.currentSong.playIndex

    } else if(this.currentSong.playMode =='random') {
      //随机
      //Math.random() [0-1]随机小数
      this.currentSong.playIndex =Math.floor(Math.random() * this.currentSong.playList.length)
    } else {
      // 列表
      this.currentSong.playIndex++
      if(this.currentSong.playIndex >=this.currentSong.playList.length ){
        //取第一首
        this.currentSong.playIndex = 0
      }
    }




    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }


  //列表移除歌曲
  removeSong(index:number){
    if(index == this.currentSong.playIndex){
      if(this.currentSong.playList.length>1){
        this.currentSong.playList.splice(index,1)
        if(this.currentSong.playIndex >= this.currentSong.playList.length){
          this.currentSong.playIndex=0
        }
        this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
      }
      else{
        this?.player?.reset()
        this.currentSong.reset()
      }
    } else{
      if(index< this.currentSong.playIndex){
        this.currentSong.playIndex--
      }
      this.currentSong.playList.splice(index,1)
    }
  }


  //释放播放器和播放资源
  async  release(){
    await this.player?.release
}
}


export const playerManager: AvPlayerManager = new AvPlayerManager()