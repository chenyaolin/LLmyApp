//
//  FRVideoPlayerView.swift
//  FilterCam
//
//  Created by chenyaolin on 2020/3/18.
//  Copyright © 2020 FilterCam. All rights reserved.
//

import UIKit
import AVFoundation

class FRPlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.frame = bounds
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }
    
}

class FRVideoPlayerView: UIView {
    
    lazy var playView = FRPlayerView(frame: .zero)
//    lazy var screenshotImgView = UIImageView(frame: .zero)
    private var observer: NSKeyValueObservation?

    var videoName: String? {
        didSet {
            
//            guard videoName.isSome else { return }
            guard let url = Bundle.main.url(forResource: videoName, withExtension: ".mp4") else { return }
            
            playView.player = AVPlayer(playerItem: AVPlayerItem(url: url))
//            if screenshotImgView.image == nil {
//                screenshotImgView.image = UIImage.image(url, imageSize: self.frame.size, requestedTime: CMTime(value: 0, timescale: 10))?.image
//            }
            
            observer = playView.player?.observe(\.status, changeHandler: { (player, _) in
//                guard let self = self else { return }
//                switch player.status {
//                case .readyToPlay:
//                    self.screenshotImgView.isHidden = true
//                default:
//                    break
//                }
            })
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("remove FRVideoPlayerView")
        pause()
        observer = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
//        addSubview(screenshotImgView)
        addSubview(playView)
        
        playView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        screenshotImgView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
}

extension FRVideoPlayerView {
    
    func reply() {
        playView.player?.currentItem?.seek(to: .zero, completionHandler: nil)
    }
    
    func play() {
        playView.player?.play()
    }
    
    func pause() {
        playView.player?.pause()
    }
    
}
