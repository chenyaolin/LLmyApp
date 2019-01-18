//
//  HUD.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import Kingfisher

enum HUDContentType {
    case progress
    case label(String?)
}

final class HUD {
    
    static func show(_ content: HUDContentType, onView view: UIView? = nil, duration: TimeInterval? = nil) {
        
        let contentView: UIView
        let isNeedCover: Bool
        switch content {
        case .progress:
            contentView = CRHUDProgressView()
            isNeedCover = true
        case .label(let message):
            contentView = CRHUDLabelView(message: message)
            isNeedCover = false
        }
        
        CRHUD.shareHUD.show(view: contentView, isNeedCover: isNeedCover, onView: view)
        if let duration = duration, duration > 0 {
            if duration <= 0.8 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+duration) {
                    CRHUD.shareHUD.hide(view: contentView)
                }
            } else {
                contentView.alpha = 0
                UIView.animate(withDuration: 0.2, animations: {
                    contentView.alpha = 1
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+duration-0.2) {
                    UIView.animate(withDuration: 0.2, animations: {
                        contentView.alpha = 0
                    }, completion: { _ in
                        CRHUD.shareHUD.hide(view: contentView)
                        contentView.alpha = 1
                    })
                }
            }
        }
    }
    
    static func hideAllHUD() {
        CRHUD.shareHUD.hideAllHUD()
    }
    
}
