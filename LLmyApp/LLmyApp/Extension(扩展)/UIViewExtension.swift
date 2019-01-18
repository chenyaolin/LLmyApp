//
//  UIViewExtension.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

/// 对UIView的扩展
extension UIView {
    
    func roundCorners(_ bounds: CGRect, corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
    }
    
    /// 裁剪 view 的圆角
    func clipRectCorner(_ cornerRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    func setStroke(_ cornerRadius: CGFloat, borderWidth: CGFloat, borderHexColor: String) {
        let color = UIColor(hex: borderHexColor)
        setStroke(cornerRadius, borderWidth: borderWidth, borderColor: color)
    }
    
    /// 设置圆角描边
    func setStroke(_ cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    /// 设置阴影
    func setShadow(_ shadowRadius: CGFloat, shadowOpacity: CGFloat, shadowOffset: CGSize, shadowHexColor: String) {
        //        self.layer.masksToBounds = false
        //        self.layer.shadowRadius = shadowRadius
        //        self.layer.shadowOpacity = Float(shadowOpacity)
        //        self.layer.shadowOffset = shadowOffset
        //        self.layer.shadowColor = UIColor(hex:shadowHexColor).cgColor
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            self.frame = CGRect(x: self.origin.x, y: self.origin.y, width: newSize.width, height: newSize.height)
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newOrigin) {
            self.frame = CGRect(x: newOrigin.x, y: newOrigin.y, width: self.size.width, height: self.size.height)
        }
    }
    
    /// X值
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            self.frame = CGRect(x: newX, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
    }
    /// Y值
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            self.frame = CGRect(x: self.origin.x, y: newY, width: self.size.width, height: self.size.height)
        }
    }
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            self.frame = CGRect(x: self.origin.x, y: self.origin.y, width: newWidth, height: self.size.height)
        }
    }
    
    var left: CGFloat {
        get {
            return frame.minX
        }
        set(newValue) {
            self.frame = CGRect(x: newValue, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
    }
    
    var right: CGFloat {
        get {
            return frame.maxX
        }
        set(newValue) {
            self.frame = CGRect(x: newValue-self.size.width, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
    }
    
    var top: CGFloat {
        get {
            return frame.minY
        }
        set(newValue) {
            self.frame = CGRect(x: self.origin.x, y: newValue, width: self.size.width, height: self.size.height)
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set(newValue) {
            self.frame = CGRect(x: self.origin.x, y: newValue-self.size.height, width: self.size.width, height: self.size.height)
        }
    }
    ///高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            self.frame = CGRect(x: self.origin.x, y: self.origin.y, width: self.size.width, height: newHeight)
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            self.frame = CGRect(x: newCenterX - self.width*0.5, y: self.y, width: self.width, height: self.height)
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            self.frame = CGRect(x: self.x, y: newCenterY - self.height*0.5, width: self.width, height: self.height)
        }
    }
    
}
