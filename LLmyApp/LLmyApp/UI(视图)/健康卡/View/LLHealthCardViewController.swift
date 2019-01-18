//
//  LLHealthCardViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift

class LLHealthCardViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    let disposeBag = DisposeBag()
    let viewModel = LLHealthCardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(LLHealthCardCell.self)
        myTableView.rowHeight = 190
        viewModel.loadData()
        bindViewModel()
    }

    private func bindViewModel() {
        
        viewModel.healthCards.asObservable().bind(to: myTableView.rx.items(LLHealthCardCell.self)) { index, healthCard, cell in
            cell.bindViewModel(healthCard: healthCard)
        }
        => disposeBag
        
    }
    
}
