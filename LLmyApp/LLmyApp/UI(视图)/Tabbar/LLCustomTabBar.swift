//
//  LLCustomTabBar.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/8.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

protocol CustomTabBarDelegate: NSObjectProtocol {
    func customBarButton(from: Int?, to: TabBarType)
}

@objc enum TabBarType: Int {
    case main = 0
    case selfDiagnosis
    case circle
    case community
    case meMain
}

class LLCustomTabBar: UIView, NibLoadable {
    
    @IBOutlet var iconImageViews: [UIImageView]!
    @IBOutlet var titleLabels: [UILabel]!
    var currentImageName = ""
    var lastImageName = ""
    var currentSelectImage = UIImageView()
    var lastSelectImage: UIImageView?
    var currentSelectTitle = UILabel()
    var lastSelectTitle: UILabel?
    weak var delegate: CustomTabBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 默认选中主页
        self.tabBarClickAction(.main)
    }
    
    @IBAction func tabBarButtonClick(_ sender: UIButton) {
        if let tabbarType = TabBarType(rawValue: sender.tag) {
            tabBarClickAction(tabbarType)
        }
    }
    
    // tabbar点击事件
    @objc func tabBarClickAction(_ tabBarType: TabBarType) {
        
        var images = [UIImage]()
        
        switch tabBarType {
        case .main: currentImageName = "主页"
        case .selfDiagnosis: currentImageName = "自诊"
        case .circle: currentImageName = "社区"
        case .community: currentImageName = "资讯"
        case .meMain: currentImageName = "我的"
        }
        
        for index in 0 ... 15 {
            if let currentIma = UIImage(named: "\(currentImageName)_\(index)") {
                images.append(currentIma)
            }
        }
        
        currentSelectImage = iconImageViews[tabBarType.rawValue]
        currentSelectTitle = titleLabels[tabBarType.rawValue]
        
        // 如果与上一次选中一致则不响应
        if currentSelectImage == lastSelectImage {
            let notificationName = Notification.Name(rawValue: "tabbarNotice")
            NotificationCenter.default.post(name: notificationName, object: nil)
            return
        } else {
            // 取消动画为防止上一次动画还未结束导致的问题
            currentSelectImage.stopAnimating()
            lastSelectImage?.stopAnimating()
            lastSelectImage?.image = UIImage(named: "\(lastImageName)默认")
            lastSelectTitle?.textColor = UIColor(hex: "#575B6E")
        }
        
        // 记录上一次点击的控件
        lastSelectImage = currentSelectImage
        lastSelectTitle = currentSelectTitle
        lastImageName = currentImageName
        
        // 设置帧动画
        currentSelectImage.image = images.last
        currentSelectTitle.textColor = UIColor(hex: "#40BB90")
        currentSelectImage.animationImages = images
        currentSelectImage.animationDuration = 0.5
        currentSelectImage.animationRepeatCount = 1
        currentSelectImage.startAnimating()
        
        // 选中回调
        self.delegate?.customBarButton(from: 0, to: tabBarType)
        
    }
    
}
