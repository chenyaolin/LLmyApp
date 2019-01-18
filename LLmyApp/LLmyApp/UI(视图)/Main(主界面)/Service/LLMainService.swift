//
//  LLMainService.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class LLMainService: NSObject {
    
     private let provider = Provider<LLMainApi>()
    
    // 获取首页banner
    func getAdvertisement() -> Observable<ServiceResult<[MainBanner]>> {
        return provider.rx.request(.getAdvertisement(), resultType: [MainBanner].self)
    }
    
}
