//
//  LLPopView.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/26.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import FWPopupView

class LLPopView: FWPopupView {
    
    private lazy var cancelBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("取消", for: .normal)
        view.backgroundColor = .yellow
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
        backgroundColor = .red
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }

}
