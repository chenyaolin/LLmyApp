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
    @IBOutlet weak var button: UIButton!
    
    lazy var loadingView: UIView = {
        let view = UIView(frame: kMainBounds)
        view.backgroundColor = UIColor.clear
        let progressView = CRHUDProgressView()
        progressView.center = CGPoint(x: kAppWidth/2, y: self.navigationController == nil ? kAppHeight/2:kAppHeight/2-64)
        view.addSubview(progressView)
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(loadingView)
        viewModel.loadData()
        
        button.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//            self?.viewModel.getAdvertisement()
            let vc = LLHealthCardViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
            
            }.disposed(by: disposeBag)
        
//        #if DEBUG
//        print("测试")
//        #else
//        print("生产")
//        #endif
        
    }
    
}
