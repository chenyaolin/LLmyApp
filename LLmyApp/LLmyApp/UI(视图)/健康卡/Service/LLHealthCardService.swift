//
//  LLHealthCardService.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import HandyJSON

class LLHealthCardService: NSObject {

    let vc = UIViewController()
    private let provider = Provider<LLHealthCardApi>(plugins: [ProgressPluginIn()])
    
    // 获取首页banner
    func requestECardNoInfo() -> Observable<ServiceResult<[CRHealthCard]>> {
//        return provider.rx.request(.get, resultType: [CRHealthCard].self)
        return provider.rx.request(.getECardNoInfo(patId: "1"), resultType: [CRHealthCard].self)
    }
    
}
