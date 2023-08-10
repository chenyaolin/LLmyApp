//
//  LLWebRtcViewController.swift
//  LLmyApp
//
//  Created by 陈林 on 2023/8/8.
//  Copyright © 2023 ManlyCamera. All rights reserved.
//

import UIKit
import BBRTC

class LLWebRtcViewController: UIViewController {
    
    private lazy var callBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        btn.setTitle("拨打", for: .normal)
        btn.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        return btn
    }()
    private lazy var incomingCallBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        btn.setTitle("接听", for: .normal)
        btn.addTarget(self, action: #selector(incomingCallAction), for: .touchUpInside)
        return btn
    }()
    private lazy var sendDataBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        btn.setTitle("发送信息", for: .normal)
        btn.addTarget(self, action: #selector(sendData), for: .touchUpInside)
        return btn
    }()
    private lazy var videoBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.titleLabel?.textColor = .white
        btn.setTitle("进入视频", for: .normal)
        btn.addTarget(self, action: #selector(videoAction), for: .touchUpInside)
        return btn
    }()
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [callBtn, incomingCallBtn, sendDataBtn, videoBtn])
        v.axis = .vertical
        v.distribution = .fillEqually
        v.spacing = 20
        return v
    }()
    
    private let rtcManager = RTCManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "同网络webrtc视频通话"
        self.view.backgroundColor = .white
        
        rtcManager.setupRTCClient(currentWifiIp: "192.168.67.231")
        rtcManager.signalClientConnet()
        rtcManager.delegate = self
        
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
        }
        callBtn.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
    }

}

extension LLWebRtcViewController {
    @objc private func callAction() {
        rtcManager.call()
    }
    
    @objc private func incomingCallAction() {
        rtcManager.incomingCall()
    }
    
    @objc private func sendData() {
        let alert = UIAlertController(title: "发送信息给对方",
                                      message: "通过WebRTC通道发信息给对方",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = ""
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "发送", style: .default, handler: { [weak self, unowned alert] _ in
            guard let dataToSend = alert.textFields?.first?.text?.data(using: .utf8) else {
                return
            }
            guard let self = self else { return }
            self.rtcManager.sendData(data: dataToSend)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func videoAction() {
        let vc = LLrtcVideoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LLWebRtcViewController: RtcDelegate {
    
    func signalClientDidConnect() {
        print("111111 信令连接")
    }
    
    func signalClientDidDisconnect() {
        print("111111 信令断开连接")
    }
    
    func webRTCClient(state: BBRTC.RtcConnectionState) {
        switch state {
        case .success:
            print("111111 rtc成功")
        case .failed:
            print("111111 rtc失败")
        }
    }
    
    func webRTCClient(didReceiveData: Data) {
        let message = String(data: didReceiveData, encoding: .utf8) ?? "(Binary: \(didReceiveData.count) bytes)"
        let alert = UIAlertController(title: "收到对方信息", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
