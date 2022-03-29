//
//  LLHealthCardViewModel.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class LLHealthCardViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    private let service = LLHealthCardService()
    var healthCards = BehaviorRelay(value: [CRHealthCard]())
    
    func loadData() {
        getECardNoInfo()
    }
    
    private func getECardNoInfo() {
        
        BQHudView.startActive()
        
        // 方式1, 可直接获取接口数据
        return service.requestECardNoInfo().subscribe(onNext: { [weak self] (value) in
            
            BQHudView.endActive()
            if let healthCards = value.content {
                print("")
//                self?.healthCards.value = healthCards
                self?.healthCards.accept(healthCards)
                for healthCard in healthCards {
                    print("\(healthCard.name ?? "没有标题") : Codable")
                }
            }
        }, onError: { (error) in
            print("\(error)")
        })
        => disposeBag
        
    }

}
