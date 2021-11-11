//
//  VideoPlayViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/10/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayViewController: UIViewController {

    var playerItem: AVPlayerItem?
    var playerController: AVPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupAVPlayerViewController()
        addObserver()
    }
    
    func setupAVPlayerViewController() {
//        guard let url = Bundle.main.url(forResource: "老照片", withExtension: ".mp4") else {
//            return
//        }
        guard let url = URL(string: "https://retell-videos.oss-cn-shenzhen.aliyuncs.com/20210928/videos/parent/2331_1632826767179.mp4") else {
            return
        }
        playerController = AVPlayerViewController()
        playerItem = AVPlayerItem(url: url)
//        playerController.player = AVPlayer(playerItem: playerItem)
        playerController.player = AVPlayer(url: url)
        playerController.videoGravity = .resizeAspect
        playerController.view.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64)
        view.addSubview(playerController.view)
    }
    
    func addObserver() {
        // 监听loadedTimeRanges属性来监听缓冲进度更新
        playerItem?.addObserver(self,
                                forKeyPath: "loadedTimeRanges",
                                options: .new,
                                context: nil)
        // 监听status属性进行播放
        playerItem?.addObserver(self,
                                forKeyPath: "status",
                                options: .new,
                                context: nil)
    }
    
    func removeObserver() {
        playerItem?.removeObserver(self, forKeyPath: "status")
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
     }

    deinit {
        removeObserver()
     }
    
    override func observeValue(forKeyPath keyPath: String?,
                                 of object: Any?,
                                 change: [NSKeyValueChangeKey : Any]?,
                                 context: UnsafeMutableRawPointer?) {
          guard let object = object as? AVPlayerItem  else { return }
          guard let keyPath = keyPath else { return }
          if keyPath == "status" {
              if object.status == .readyToPlay { //当资源准备好播放，那么开始播放视频
                  playerController?.player?.play()
                  print("正在播放...，视频总长度:\(formatPlayTime(seconds: CMTimeGetSeconds(object.duration)))")
              } else if object.status == .failed || object.status == .unknown {
                  print("播放出错")
              }
          } else if keyPath == "loadedTimeRanges" {
              let loadedTime = availableDurationWithplayerItem()
              print("当前加载进度\(loadedTime)")
          }
    }
    
    // 将秒转成时间字符串的方法，因为我们将得到秒。
    func formatPlayTime(seconds: Float64) -> String {
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    // 计算当前的缓冲进度
    func availableDurationWithplayerItem() -> TimeInterval {
        guard let loadedTimeRanges = playerController.player?.currentItem?.loadedTimeRanges,
            let first = loadedTimeRanges.first else {
                 fatalError()
         }
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start) // 本次缓冲起始时间
        let durationSecound = CMTimeGetSeconds(timeRange.duration)// 缓冲时间
        let result = startSeconds + durationSecound// 缓冲总长度
        return result
    }

}
