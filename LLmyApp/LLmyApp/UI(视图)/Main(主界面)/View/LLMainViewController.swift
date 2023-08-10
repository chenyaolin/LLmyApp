//
//  LLMainViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/8.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class LLMainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = LLMainViewModel()
    
    private let datas: [MainItem] = MainItem.allValues
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (kAppWidth - 24 - 10) / 2 - 0.1, height: 44)
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(LLMainCollectionViewCell.self)
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadData()
        
        self.view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.bottom.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo((kAppWidth - 24))
        }
        
        let btn = UIButton()
        btn.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
        
        }.disposed(by: disposeBag)
        
    }
    
}

extension LLMainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(LLMainCollectionViewCell.self, indexPath: indexPath)
        cell.setDatas(model: datas[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = datas[indexPath.item].vc
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
