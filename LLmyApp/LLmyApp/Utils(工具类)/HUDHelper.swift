//
//  HUDHelper.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

final class HUDHelper {
    
    /// 显示消息HUD
    ///
    /// - Parameters:
    ///   - message: message
    ///   - duration: duration
    class func show(message: String?, duration: TimeInterval) {
        HUD.show(.label(message), duration: duration)
    }
    
    /// 显示进度HUD
    class func showProgress(onView view: UIView? = nil) {
        HUD.show(.progress, onView: view)
    }
    
    /// 隐藏进度HUD
    class func hideProgress() {
        HUD.hideAllHUD()
    }
}
