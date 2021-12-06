//
//  LLBookPlayPopView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/12/3.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLBookPlayPopView: FWPopupView {
    
    private lazy var cancelBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("取消", for: .normal)
        view.setBackgroundImage(UIImage(named: "确定按钮"), for: .normal)
        return view
    }()
    
    private lazy var okBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("确定", for: .normal)
        view.setBackgroundImage(UIImage(named: "确定按钮"), for: .normal)
        return view
    }()
    
    private lazy var closeBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "关闭按钮"), for: .normal)
        return view
    }()
    
    private lazy var bgImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "色彩平衡"))
        return view
    }()

    init(withTip tip: String) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

}
