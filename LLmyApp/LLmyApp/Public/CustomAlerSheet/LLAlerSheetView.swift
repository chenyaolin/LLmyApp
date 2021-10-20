//
//  LLAlerSheetView.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/10/9.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLAlerSheetView: UIView {
    
    private lazy var myMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "000000", alpha: 0.5)
        return view
    }()
    
    private lazy var customContenView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var showView: UIView = {
        let v = UIView()

        let cancelBtn = UIButton(type: .custom)
        let sureBtn = UIButton(type: .custom)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor(hex: "425E5F"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor(hex: "40BB90"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "EEEEEE")
        
        let toolbarView = UIView()
        toolbarView.addSubview(cancelBtn)
        toolbarView.addSubview(sureBtn)
        toolbarView.addSubview(lineView)
        cancelBtn.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        sureBtn.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        lineView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        v.addSubview(toolbarView)
        v.addSubview(customContenView)
        toolbarView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        customContenView.snp.makeConstraints {
            $0.top.equalTo(toolbarView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        v.backgroundColor = .white
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0, alpha: 0)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(myMaskView)
        myMaskView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myMaskView.addSubview(showView)
        showView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(260)
            $0.bottom.equalToSuperview().offset(260)
        }
    }
    
    func show(_ customV: UIView, finsh: @escaping ((_ result: String) -> Void)) {
        
        customContenView.addSubview(customV)
        customV.frame = customContenView.bounds
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        window?.addSubview(self)
        layoutIfNeeded()
        
        let tapMaskView = UITapGestureRecognizer(target: self, action: #selector(hideAndExcuteBlock(_:)))
        tapMaskView.delegate = self
        myMaskView.addGestureRecognizer(tapMaskView)
        
        showView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(0)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.myMaskView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            self.layoutIfNeeded()
        }, completion: { _ in
        })
        
    }
    
    @objc func hideAndExcuteBlock(_ bol: Bool) {
        
        showView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(260)
        }
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.myMaskView.backgroundColor = UIColor(white: 0.0, alpha: 0)
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
            if bol {
            } else {
            }
        })
    }
    
    @objc private func cancelClick() {
        self.hideAndExcuteBlock(false)
    }
    
    @objc private func sureClick() {
        self.hideAndExcuteBlock(true)
    }

}

extension LLAlerSheetView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if String(describing: type(of: touchView.self)) == "UITableViewCellContentView" {
                return false
            }
        }
        return true
    }
    
}
