//
//  LLEqualSpaceCollectionCell.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

struct TagModel: Codable, Equatable {
    
    var tag_name: String?
    var tag_id: String?
//    var isSecleted: Bool?
    
//    init(tag_name: String, tag_id: String, isSecleted: Bool = false) {
//        self.isSecleted = isSecleted
//        self.tag_name = tag_name
//        self.tag_id = tag_id
//    }
}

class LLEqualSpaceCollectionCell: UICollectionViewCell, Reusable {
    
    private lazy var titleLbel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .yellow
        clipRectCorner(3)
        
        contentView.addSubview(titleLbel)
        titleLbel.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(10)
        }
//        titleLbel.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
    }
    
    func bindData(_ data: TagModel) {
        titleLbel.text = data.tag_name
    }
    
}
