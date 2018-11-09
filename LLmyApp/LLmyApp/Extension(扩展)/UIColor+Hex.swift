//
//  UIColor+Hex.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/8.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 根据RGBA返回UIColor
    ///
    /// - Parameters:
    ///   - red: 0-1
    ///   - green: 0-1
    ///   - blue: 0-1
    ///   - alpha: 0-1
    /// - Returns: UIColor
    class func colorWith(_ red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        return color
    }
    
    /// 根据16进制颜色码构造UIColor
    ///
    /// - Parameter hex: 颜色码 eg:"0x4162ff" "#4162FF" "4162ff"
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }
    
    /// /// 根据16进制颜色码和透明度构造UIColor
    ///
    /// - Parameters:
    ///   - hex: 颜色码 eg:"0x4162ff" "#4162FF" "4162ff"
    ///   - alpha: 透明度
    convenience init(hex: String, alpha: CGFloat) {
        
        var hexColor = hex
        
        if hexColor.hasPrefix("0x") || hexColor.hasPrefix("0X") {
            hexColor = String(hex[hexColor.index(hexColor.startIndex, offsetBy: 2)...])
        }
        
        if hexColor.hasPrefix("#") {
            hexColor = String(hexColor[hexColor.index(hexColor.startIndex, offsetBy: 1)...])
        }
        
        guard hexColor.count >= 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        // 存储转换后的数值
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        
        // 分别转换进行转换
        var endIndex = hexColor.index(hexColor.startIndex, offsetBy: 2)
        Scanner(string: String(hexColor[..<endIndex])).scanHexInt32(&red)
        
        var startIndex = hexColor.index(hexColor.startIndex, offsetBy: 2)
        endIndex = hexColor.index(hexColor.startIndex, offsetBy: 4)
        Scanner(string: String(hexColor[startIndex..<endIndex])).scanHexInt32(&green)
        
        startIndex = hexColor.index(hexColor.startIndex, offsetBy: 4)
        Scanner(string: String(hexColor[startIndex...])).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    /// color2image
    ///
    /// - Returns: UIImage
    func image() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension String {
    /// 返回hex颜色
    func hexColor() -> UIColor {
        return UIColor(hex: self)
    }
}
