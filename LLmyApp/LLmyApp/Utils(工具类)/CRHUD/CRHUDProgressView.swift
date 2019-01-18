//
//  CRHUDProgressView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

class CRHUDProgressView: UIImageView {
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private override init(image: UIImage?) {
        super.init(image: image)
    }
    
    init() {
        super.init(frame: .zero)
        self.size = CGSize(width: 70, height: 70)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "加载", ofType: "gif")!)
        self.kf.setImage(with: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
