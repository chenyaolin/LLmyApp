//
//  LLScrollViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/11/16.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LLScrollViewController: UIViewController {
    
    var testData = BehaviorRelay<[String?]>(value: [])
    let disposeBag = DisposeBag()
    
    private lazy var myTableview: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        return view
    }()
    
    private lazy var bigScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var bigScrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var testView1: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        
        testData.accept(["1","2","3"])
        myTableview.register(LLScrollViewDemoCell.self)
        myTableview.rowHeight = 60
        myTableview.delegate = self
        
                view.addSubview(bigScrollView)
                bigScrollView.addSubview(bigScrollContentView)
                bigScrollView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                bigScrollContentView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                    $0.height.equalTo(bigScrollView.snp.height)
                    $0.width.equalTo(kAppWidth+100)
                }
        bigScrollContentView.addSubview(myTableview)
        myTableview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        view.addSubview(bigScrollView)
//        bigScrollView.addSubview(bigScrollContentView)
//        bigScrollView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        bigScrollContentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.height.equalTo(bigScrollView.snp.height)
//            $0.width.equalTo(kAppWidth+100)
//        }
//
//        bigScrollContentView.addSubview(scrollView)
//        scrollView.addSubview(scrollContentView)
//        scrollContentView.addSubview(testView)
//        scrollContentView.addSubview(testView1)
//        scrollView.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//            $0.width.height.equalTo(200)
//        }
//        scrollContentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.height.equalTo(scrollView.snp.height)
//            $0.width.equalTo(500)
//        }
//        testView.snp.makeConstraints {
//            $0.top.left.bottom.equalToSuperview()
//            $0.width.equalTo(50)
//        }
//        testView1.snp.makeConstraints {
//            $0.left.equalTo(testView.snp.right)
//            $0.top.right.bottom.equalToSuperview()
//            $0.width.equalTo(500)
//        }
    }
    
    private func bindViewModel() {
        
        testData.asObservable().bind(to: myTableview.rx.items(LLScrollViewDemoCell.self)) { index, data, cell in
        }
        => disposeBag
        
    }

}

extension LLScrollViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let sectionHeaderView = HomeSectionHeaderView.headerView(with: tableView)
//        sectionHeaderView.delegate = self
//        sectionHeaderView.index = section
//        if defaultHomeModels.count > 0 {
//            sectionHeaderView.config(model: defaultHomeModels[section])
//        }
//        return sectionHeaderView
        
        let sectionView = UIView()
//        let testView = UIView()
//        testView.backgroundColor = .green
        sectionView.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
            $0.width.equalTo(1000)
        }
        
//        sectionView.backgroundColor = .red
        
        return sectionView
    }
    
}
