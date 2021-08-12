//
//  LLMarkView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/8/4.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLMarkView: UIView {
    
    private lazy var cricleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var cricleView1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 8)
//        view.backgroundColor = .gray
        view.textColor = .white
        return view
    }()
    
    private lazy var titleLabel1: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 8)
//        view.backgroundColor = .green
        view.textColor = .white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
//        backgroundColor = .green
        addSubview(cricleView)
        addSubview(cricleView1)
        addSubview(titleLabel)
        addSubview(titleLabel1)
        cricleView.frame = CGRect(x: -3, y: -3, width: 6, height: 6)
//        cricleView1.frame = CGRect(x: -3, y: -3-25.6, width: 6, height: 6)
        cricleView1.frame = CGRect(x: -3, y: -3-33, width: 6, height: 6)
        titleLabel.frame = CGRect(x: 10, y: -10, width: 90, height: 20)
        titleLabel1.frame = CGRect(x: 10, y: -10, width: 90, height: 20)
//        titleLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
    }
    
    var zero: CGFloat = 10.0
    var maxCount: CGFloat = 100.0
    var spacing: CGFloat = 0
    var nextY: CGFloat = 0
    func setMarkerView(withY y: CGFloat, xPy: CGFloat, x: CGFloat) {
        titleLabel.text = String(Int(y))
//        spacing = xPy / y
//        nextY = x * 2
//        cricleView1.y = -3-nextY*spacing
        
//        let zero = (261.2275390625 - 32.8388671875) / 120
//        spacing = y / zero
        
        spacing = (xPy - zero) / (maxCount - y)
        nextY = x * 2
        cricleView1.y = -3-nextY*spacing
        
        titleLabel1.y = -10-nextY*spacing
        titleLabel1.text = String(Int(y+x * 2))

    }

}
