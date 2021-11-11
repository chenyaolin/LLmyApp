//
//  LLVideoPlayViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/10/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLVideoPlayViewController: UIViewController {
    
    private lazy var videoView: FRVideoPlayerView = {
        let view = FRVideoPlayerView()
        view.videoName = "老照片"
        view.playView.playerLayer.videoGravity = .resizeAspect
        view.play()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
    }

}

extension LLVideoPlayViewController {
    
    private func setupUI() {
        
        view.addSubview(videoView)
        videoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
