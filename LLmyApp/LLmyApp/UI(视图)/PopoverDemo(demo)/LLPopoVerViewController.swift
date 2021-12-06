//
//  LLPopoVerViewController.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/12/2.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLPopoVerViewController: UIViewController {
    
    private lazy var popoverBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("气泡弹窗", for: .normal)
        view.backgroundColor = .orange
        view.addTarget(self, action: #selector(popoVerAction), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(popoverBtn)
        popoverBtn.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func popoVerAction() {
        let tabCon = UITableViewController(style: .plain)
        tabCon.modalPresentationStyle = .popover
        tabCon.preferredContentSize = CGSize(width: 100, height: 100)
        tabCon.popoverPresentationController?.sourceView = self.popoverBtn
//        tabCon.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 65, width: 0, height: 0)
        tabCon.popoverPresentationController?.delegate = self
        tabCon.popoverPresentationController?.permittedArrowDirections = .up
        self.present(tabCon, animated: true, completion: nil)
    }

}

extension LLPopoVerViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

}
