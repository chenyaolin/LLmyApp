//
//  LLMainViewModel.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class LLMainViewModel: NSObject {
    
    private let service = LLMainService()
    let disposeBag = DisposeBag()
    
    func loadData() {
        
        // 订阅接口数据
//        getAdvertisement().asObservable().subscribe(onNext: { (banners) in
//            for banner in banners {
//                print("\(banner.title ?? "没有标题") : Codable")
//            }
//        }).disposed(by: disposeBag)
        
        getAdvertisement()
//        getAdvertisementWihtHandyJSON()
    }
    
   // 使用Codable原生协议来转模型(swift 4.0才支持)
    func getAdvertisement() {
        
        // 方式1, 可直接获取接口数据
        return service.getAdvertisement().subscribe(onNext: { (value) in
            if let banners = value.content {
                for banner in banners {
                    print("\(banner.shareTitle ?? "没有标题") : Codable")
                }
            }
        }, onError: { (error) in
            print("\(error)")
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        // 方式2, 需在订阅方法内获得接口数据
//        return service.getAdvertisement().flatMap { (result) -> Observable<[MainBanner]> in
//            return Observable.of(result.content!)
//            }.catchError({ (error) -> Observable<[MainBanner]> in
//                return Observable.of([MainBanner]())
//            })
//            .share(replay: 1)
    }
    
    // 利用HandyJSON框架转模型
    func getAdvertisementWihtHandyJSON() {
        
        let privoder = MoyaProvider<LLMainApi>()
        privoder.rx.request(.getAdvertisement).asObservable().mapModel(LLMainBanner.self).subscribe(onNext: { (value) in
            if let banners = value.lists {
                for banner in banners {
                    print("\(banner.title ?? "没有标题") : HandyJSON")
                }
            }
        }, onError: { (error) in
            print("\(error)")
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
}
