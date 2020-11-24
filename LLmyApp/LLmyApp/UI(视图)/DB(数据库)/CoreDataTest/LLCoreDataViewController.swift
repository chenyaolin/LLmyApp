//
//  LLCoreDataViewController.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2020/10/30.
//  Copyright © 2020 ManlyCamera. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LLCoreDataViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("新增", for: .normal)
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        addButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
            self?.addModel()
            } => disposeBag
        
//        deleteButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//
//            let isOk = self?.deleteTable() ?? false
//            if isOk {
//                print("删除数据成功")
//            } else {
//                print("删除数据失败")
//            }
//            } => disposeBag
//
//        updateButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//            let isOk = self?.updateModel() ?? false
//            if isOk {
//                print("更新数据成功")
//            } else {
//                print("更新数据失败")
//            }
//            } => disposeBag
//
//        checkButton.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//            self?.checkModel()
//            } => disposeBag
        
    }
    
    func addModel() {
        LLDBManager.default.asynSaveInPrivate { (context) in
            
            let info = MyFishModel(t_name: "小鱼仔1", t_loveFood: "鱼1", t_age: 3)
            Fish.create(info, context: context)
        }
    }

}

extension LLCoreDataViewController {
    
    private func setupUI() {
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(44)
        }
    }
    
}
