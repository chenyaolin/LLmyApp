//
//  CRHUD.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

final class CRHUD {
    private init () { }
    static let shareHUD = CRHUD()
    
    private var contentView = UIView(frame: kMainBounds)
    private var showViews: [UIView] = []
    
    func show(view: UIView, isNeedCover isNeed: Bool, onView: UIView? = nil) {
        let offsetY: CGFloat = onView == nil ? 0:64
        view.center = CGPoint(x: kAppWidth/2, y: kAppHeight/2-offsetY)
        
        let dispalyView = onView != nil ? onView!:UIApplication.shared.keyWindow!
        
        if isNeed {
            contentView.addSubview(view)
            if contentView.superview == nil {
                dispalyView.addSubview(contentView)
            }
        } else {
            showViews.append(view)
            dispalyView.addSubview(view)
        }
    }
    
    func hide(view: UIView) {
        if let index = showViews.index(of: view) {
            view.removeFromSuperview()
            showViews.remove(at: index)
        }
        if contentView.subviews.count < 1 && contentView.superview != nil {
            contentView.removeFromSuperview()
        }
    }
    
    func hideAllHUD() {
        for view in showViews {
            view.removeFromSuperview()
        }
        showViews.removeAll()
        contentView.removeFromSuperview()
    }
}
