//
//  LLTestIMViewController.swift
//  LLmyApp
//
//  Created by 陈林 on 2022/4/6.
//  Copyright © 2022 ManlyCamera. All rights reserved.
//

import UIKit
import AuroraIMUI
import Photos

class LLTestIMViewController: UIViewController {
    
    @IBOutlet weak var messageCollectionView: IMUIMessageCollectionView!
    @IBOutlet weak var myInputView: IMUIInputView!
    var currentType:IMUIFeatureType = .voice
    
    private lazy var submitItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "提交", style: UIBarButtonItem.Style.plain, target: self, action: #selector(submitSuggestReq))
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                    NSAttributedString.Key.foregroundColor: UIColor(hex: "000000")]
        item.setTitleTextAttributes(attr, for: .normal)
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.messageCollectionView.delegate = self
        self.myInputView.delegate = self
        
        self.navigationItem.rightBarButtonItem = submitItem
    }
    
    @objc func submitSuggestReq() {
        
//        let outGoingmessage = MyMessageModel(voicePath: "voicePath", duration: CGFloat(1), isOutGoing: true)
//        let inCommingMessage = MyMessageModel(voicePath: "voicePath", duration: CGFloat(1), isOutGoing: false)
        let myMessage = MyMessageModel(text: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", isOutGoing: true)
        let otherMessage = MyMessageModel(text: "哈哈哈dfdas ", isOutGoing: false)
        self.messageCollectionView.appendMessage(with: myMessage)
        self.messageCollectionView.appendMessage(with: otherMessage)

    }

}

extension LLTestIMViewController: IMUIInputViewDelegate {
    
    func keyBoardWillShow(height: CGFloat, durationTime: Double) {
      self.messageCollectionView.scrollToBottom(with: true)
    }
    
    func sendTextMessage(_ messageText: String) {
      let outGoingmessage = MyMessageModel(text: messageText, isOutGoing: true)
      let inCommingMessage = MyMessageModel(text: messageText, isOutGoing: false)
      self.messageCollectionView.appendMessage(with: outGoingmessage)
      self.messageCollectionView.appendMessage(with: inCommingMessage)
    }
    
    func switchToMicrophoneMode(recordVoiceBtn: UIButton) {
  //    self.showToast(alert: "switchToMicrophoneMode")
    }
    
    func switchToCameraMode(cameraBtn: UIButton) {
  //    self.showToast(alert: "switchToCameraMode")
    }
    
    func switchToEmojiMode(cameraBtn: UIButton) {
  //    self.showToast(alert: "switchToEmojiMode")
    }
    
    func didShootPicture(picture: Data) {
//      let imgPath = self.getPath()
//      DispatchQueue.main.async {
//        let imageView = MyImageView()
//        self.imageViewArr.append(imageView)
//
//        do {
//          try picture.write(to: URL(fileURLWithPath: imgPath))
//          DispatchQueue.main.async {
//            let outGoingmessage = MyMessageModel(imagePath: imgPath, isOutGoing: true)
//            self.messageCollectionView.appendMessage(with: outGoingmessage)
//          }
//        } catch {
//          print("write image file error")
//        }
//      }
      
      
    }
    
    func startRecordVoice() {
  //    self.showToast(alert: "startRecordVoice")
    }
    
    func startRecordVideo() {
  //    self.showToast(alert: "startRecordVideo")
    }
    
    func finishRecordVideo(videoPath: String, durationTime: Double) {
      let outGoingmessage = MyMessageModel(videoPath: videoPath, isOutGoing: true)
      let inCommingMessage = MyMessageModel(videoPath: videoPath, isOutGoing: false)
      self.messageCollectionView.appendMessage(with: outGoingmessage)
      self.messageCollectionView.appendMessage(with: inCommingMessage)
    }
    
    func finishRecordVoice(_ voicePath: String, durationTime: Double) {
      
      let outGoingmessage = MyMessageModel(voicePath: voicePath, duration: CGFloat(durationTime), isOutGoing: true)
      let inCommingMessage = MyMessageModel(voicePath: voicePath, duration: CGFloat(durationTime), isOutGoing: false)
      self.messageCollectionView.appendMessage(with: outGoingmessage)
      self.messageCollectionView.appendMessage(with: inCommingMessage)
    }
    
    func didSeletedGallery(AssetArr: [PHAsset]) {
//      for asset in AssetArr {
//        switch asset.mediaType {
//        case .image:
//          let option = PHImageRequestOptions()
//          option.isSynchronous = true
//          option.isNetworkAccessAllowed = true
//
//          imageManage.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth/4, height: asset.pixelHeight/4), contentMode: .aspectFill, options: option, resultHandler: { [weak self] (image, _) in
//            let imageData = image!.pngData()
//            self?.didShootPicture(picture: imageData!)
//          })
//          break
//        default:
//          break
//        }
//      }
    }
    
    func getPath() -> String {
      var recorderPath:String? = nil
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yy-MMMM-dd"
      recorderPath = "\(NSHomeDirectory())/Documents/"
      recorderPath?.append("\(NSDate.timeIntervalSinceReferenceDate)")
      return recorderPath!
    }
    
}

extension LLTestIMViewController: IMUIMessageMessageCollectionViewDelegate {
    
    func messageCollectionView(didTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
      self.showToast(alert: "tap message bubble")
    }
    
    func messageCollectionView(didTapHeaderImageInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
      self.showToast(alert: "tap header image")
    }
    
    func messageCollectionView(didTapStatusViewInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
      self.showToast(alert: "tap status View")
    }
    
    func showToast(alert: String) {
        
        let toast = UIAlertView(title: alert, message: nil, delegate: nil, cancelButtonTitle: nil)
        toast.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            toast.dismiss(withClickedButtonIndex: 10, animated: true)
        })
    }
    
}
