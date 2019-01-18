//
//  Provider.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import RxSwift
import Moya

/// ProviderType
protocol ProviderType {
    associatedtype Target: TargetType
    var moyaProvider: MoyaProvider<Target> {get}
}

/// Provider
class Provider<Target: Requestable>: ProviderType {
    var moyaProvider: MoyaProvider<Target>
    
    init(plugins: [PluginType] = []) {
        self.moyaProvider = MoyaProvider<Target>(plugins: plugins)
    }
}

extension Provider: ReactiveCompatible {}

extension Reactive where Base: ProviderType {
    
    /// 请求数据
    func request<T: Requestable, O: Modelable>(_ token: Base.Target, resultType: O.Type, callbackQueue: DispatchQueue? = nil) -> Observable<ServiceResult<O>> where Base.Target == T {
        return request(token, callbackQueue: callbackQueue)
            .flatMap { response -> Observable<Response> in
                
                if response.statusCode == 401 { // 网关错误
                    
//                    HUDHelper.showProgress()
                    
                    return Observable<Response>.create { (observer) -> Disposable in
                        let data = response.mapModel(GatewayError.self)
                        // 去获取网关token
                        GatewayHelper.requestCRAPIGatewayAccessToken(withErrorCode: data.returnCode ?? 99999, {
                            print("\(GatewayHelper.default.accessToken)")
                            observer.onNext(response)
                        })
                        return Disposables.create()
                    }
                } else {
//                    HUDHelper.hideProgress()
                    return Observable.just(response)
                }
            }
            .filterSuccessfulStatusCodes()
            .ServiceResultMap(resultType)
            .retry(2)
        
    }
    
    private func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        
        return self.base.moyaProvider.rx
            .request(token, callbackQueue: callbackQueue)
            .asObservable()
            // 加上这句, 得到网关token后不会retry
            //            .filterSuccessfulStatusCodes()
            .handleMoyaError()
        
    }
    
}
