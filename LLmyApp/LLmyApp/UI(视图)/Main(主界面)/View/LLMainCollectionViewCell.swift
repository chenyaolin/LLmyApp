//
//  LLMainCollectionViewCell.swift
//  LLmyApp
//
//  Created by 陈林 on 2023/8/10.
//  Copyright © 2023 ManlyCamera. All rights reserved.
//

import UIKit

class LLMainCollectionViewCell: UICollectionViewCell, Reusable {
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textAlignment = .center
        l.textColor = .gray
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubview() {
        contentView.backgroundColor = .yellow
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setDatas(model: MainItem) {
        titleLabel.text = model.title
    }
    
}
