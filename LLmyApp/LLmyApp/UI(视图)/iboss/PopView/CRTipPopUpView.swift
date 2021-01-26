//
//  CRTipPopUpView.swift
//  PatientAPP
//
//  Created by chenyaolin on 2018/12/8.
//  Copyright © 2018年 ChenRui. All rights reserved.
//

import UIKit
import RxSwift

class CRTipPopUpView: UIView {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tipTextView: UITextView!
    @IBOutlet weak var sureBtn: UIButton!
    let disposeBag = DisposeBag()
    
    // 提示内容
    var remark: String = "" {
        didSet {
            tipTextView.text = remark
            print("\(remark)")
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        view?.frame = UIScreen.main.bounds
        view?.layoutMargins = layoutMargins
        if let aView = view {
            addSubview(aView)
            setupUI()
        }
    }
    
    private func setupUI() {
        
        contentView.clipRectCorner(2)
        
        // 关闭
//        closeBtn.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//            self?.dismiss()
//            } => disposeBag
        
        // 确定
//        sureBtn.rx.controlEvent(.touchUpInside).subscribe { [weak self] (event) in
//            self?.dismiss()
//            } => disposeBag
        
        sureBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
    }
    
    // 展示
    func show() {
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3) {
            weakSelf?.bgView.alpha = 0.7
        }
    }
    
    @objc private func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0
            self.closeBtn.removeFromSuperview()
            self.contentView.removeFromSuperview()
//            self.closeBtn.removeFromSuperview()
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}
