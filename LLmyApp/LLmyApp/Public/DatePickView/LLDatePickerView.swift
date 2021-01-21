//
//  LLDatePickerView.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class YearAndMonthModel: NSObject, Codable {
    /**  */
    public var year: String?
    /**  */
    public var month: String?
    /**  */
    public var day: String?
}

class LLDatePickerView: UIView, NibLoadable {
    
    @IBOutlet weak var myDateView: UIDatePicker!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myMaskView: UIView!
    @IBOutlet weak var myPickerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var myDatePickerViewBottom: NSLayoutConstraint!
    let months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var currentDate = YearAndMonthModel()
    var resultDate = YearAndMonthModel()
    var dataSource = [[YearAndMonthModel]]()
    var pickFinishBlock: ((_ result: YearAndMonthModel) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor(white: 0, alpha: 0)
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        setDataSource()
    }
    
    func setDataSource() {
        
        var yearArr = [YearAndMonthModel]()
        var monthArr = [YearAndMonthModel]()
        var today = Date()
        resultDate.year = String(today.year)
        resultDate.month = String(today.month)
        resultDate.day = String(today.day)
        
        for i in 0 ..< 50 {
            today = (Date() - i.years)!
            let yearsModel = YearAndMonthModel()
            yearsModel.year = String(today.year)
            yearArr.append(yearsModel)
        }
        
        for month in months {
            let monthModel = YearAndMonthModel()
            monthModel.month = month
            monthArr.append(monthModel)
        }
        dataSource = [yearArr, monthArr]
    
    }
    
    func show(WithShowDay isShowDay: Bool) {
        
//        let loc = Locale(identifier: "zh")
        let loc = Locale(identifier: "zh_GB")
        myDateView.datePickerMode = .dateAndTime
        myDateView.locale = loc
        myDateView.maximumDate = Date()
        
        if isShowDay == true {
            myPickerView.isHidden = true
            myDateView.isHidden = !myPickerView.isHidden
        } else {
            myPickerView.isHidden = false
            myDateView.isHidden = !myPickerView.isHidden
        }
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        // 默认滚动到当前月份
        myPickerView.selectRow(Date().month - 1, inComponent: 1, animated: false)
        
        layoutIfNeeded()
        myPickerView.delegate = self
        
        let tapMaskView = UITapGestureRecognizer(target: self, action: #selector(hideAndExcuteBlock(_:)))
        myMaskView?.addGestureRecognizer(tapMaskView)
        myPickerView.reloadAllComponents()
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.myMaskView?.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            self.myPickerViewBottom.constant = 0
            self.myDatePickerViewBottom.constant = 0
            self.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    @objc func hideAndExcuteBlock(_ bol: Bool) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
            self.myMaskView?.backgroundColor = UIColor(white: 0.0, alpha: 0)
            self.myPickerViewBottom.constant = -260
            self.myDatePickerViewBottom.constant = -260
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
            if bol {
                if self.pickFinishBlock != nil {
                    self.pickFinishBlock!(self.resultDate)
                }
            } else {
                // 回滚到原始状态
                self.myPickerView.selectRow(0, inComponent: 0, animated: false)
            }
        })
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.hideAndExcuteBlock(false)
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        self.hideAndExcuteBlock(true)
    }
    
    @IBAction func dateValueChange(_ sender: UIDatePicker) {
        resultDate.year = String(sender.date.year)
        resultDate.month = String(sender.date.month)
        resultDate.day = String(sender.date.day)
    }
    
}

extension LLDatePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let currentArr = dataSource[component]
        return currentArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currentDate = dataSource[component][row]
        if component == 0 {
            return (currentDate.year ?? "") + "年"
        } else {
            return (currentDate.month ?? "") + "月"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentDate = dataSource[component][row]
        if component == 0 {
            resultDate.year = currentDate.year
        } else {
            if let month = currentDate.month {
                if let monthInt = Int(month) {
                    if monthInt > Date().month {
                        // 默认滚动到当前月份
                        myPickerView.selectRow(Date().month - 1, inComponent: 1, animated: true)
                        resultDate.month = months[Date().month - 1]
                    } else {
                        resultDate.month = currentDate.month
                    }
                }
            }
        }
    }
    
}
