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

protocol MainItemProtocol {
    var title: String { get }
    var vc: UIViewController { get }
}

enum MainItem: CaseIterable, MainItemProtocol {
    
    /* cr健康卡，测试rxswift网络请求 */
    case healthCard
    /* equalSpace, 自适应collection */
    case equalSpace
    /* 图表 */
    case charts
    /* coreData，数据库测试 */
    case coreData
    /* videoPlay，gomo老照片 */
    case gomoVideoPlay
    /* 视频播放，通用 */
    case videoPlay
    /* 极光im */
    case j_IM
    /* PopoVer, 泡泡指示弹窗 */
    case popoVer
    /* webrtc视频通话 */
    case webRtc
    
    static var allValues: [Self] {
        return self.allCases
    }
    
    var title: String {
        switch self {
        case .healthCard:    return "健康卡"
        case .equalSpace:    return "equalSpace"
        case .charts:        return "图表"
        case .coreData:      return "数据库"
        case .gomoVideoPlay: return "老照片视频"
        case .videoPlay:     return "通用视频"
        case .j_IM:          return "极光im"
        case .popoVer:       return "泡泡窗"
        case .webRtc:        return "rtc视频"
        }
    }

    var vc: UIViewController {
        switch self {
        case .healthCard:    return LLHealthCardViewController()
        case .equalSpace:    return LLEqualSpaceCollectionVc()
        case .charts:        return LLChartsViewController()
        case .coreData:      return LLCoreDataViewController()
        case .gomoVideoPlay: return LLVideoPlayViewController()
        case .videoPlay:     return VideoPlayViewController()
        case .j_IM:          return LLTestIMViewController()
        case .popoVer:       return LLPopoVerViewController()
        case .webRtc:        return LLWebRtcViewController()
        }
    }
}

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
