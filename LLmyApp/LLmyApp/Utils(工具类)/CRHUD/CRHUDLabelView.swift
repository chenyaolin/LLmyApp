//
//  CRHUDLabelView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

private let kMaxLabelHUDWidth = 300
private let kMaxLabelHUDHeight = 300
class CRHUDLabelView: UIView {
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private let label = UILabel()
    
    init(message: String?) {
        super.init(frame: .zero)
        
        let labelMaxWidth = kMaxLabelHUDWidth - 50
        let string = message ?? ""
        let font = UIFont.systemFont(ofSize: 18)
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect: CGRect = string.boundingRect(with: CGSize(width: labelMaxWidth, height: Int.max), options: option, attributes: attributes, context: nil)
        
        let hudWidth: CGFloat = min(rect.width+50, CGFloat(kMaxLabelHUDWidth))
        let hudHeight: CGFloat = min(rect.height+44, CGFloat(kMaxLabelHUDHeight))
        
        let label = UILabel(frame: CGRect(x: 25, y: 22, width: hudWidth-50, height: hudHeight-44))
        label.text = message
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        self.addSubview(label)
        
        self.size = CGSize(width: hudWidth, height: hudHeight)
        self.backgroundColor = UIColor(hex: "000000", alpha: 0.8)
        self.clipRectCorner(4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
