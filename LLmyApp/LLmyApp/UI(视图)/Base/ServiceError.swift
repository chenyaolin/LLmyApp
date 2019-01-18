//
//  ServiceError.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import Moya
import RxSwift

enum ServiceError: Swift.Error {
    case service
    case network
    case objectMap
    case unknown
    case loginInvalid
}

extension ServiceError {
    var localizedDescription: String {
        switch self {
        case .service:
            return "服务器错误"
        case .network:
            return "网络不可用"
        case .objectMap:
            return "解析错误"
        case .unknown:
            return "未知错误"
        case .loginInvalid:
            return "登录失效"
        }
    }
}

extension Observable where Element: Response {
    
    func retryAPI() -> Observable<Element> {
        return self.retry()
    }
    
    func handleMoyaError() -> Observable<Element> {
        return self.catchError({ error in
            guard let moyaError = error as? MoyaError else {
                throw ServiceError.unknown
            }
            switch moyaError {
            case .imageMapping:
                throw ServiceError.service
            case .jsonMapping:
                throw ServiceError.service
            case .stringMapping:
                throw ServiceError.service
            case .objectMapping:
                throw ServiceError.service
            case .encodableMapping:
                throw ServiceError.service
            case .statusCode(let response):
                
                // 网关错误
                if response.statusCode == 401 {
                    throw ServiceError.loginInvalid
                } else {
                    throw ServiceError.service
                }
            case .underlying:
                //                switch NetworkHelper.default.status {
                //                case .notReachable:
                //                    throw ServiceError.network
                //                default:
                //                    throw ServiceError.service
                //                }
                throw ServiceError.service
            case .requestMapping:
                throw ServiceError.unknown
            case .parameterEncoding:
                throw ServiceError.unknown
            }
        }).catchError({ (error) -> Observable<Element> in
            
            guard let serviceError = error as? ServiceError else {
                throw ServiceError.unknown
            }
            
            switch serviceError {
            case .service:
                break
            case .network:
                break
            case .objectMap:
                break
            case .unknown:
                break
            case .loginInvalid:
                
                //                let rootVc = UIApplication.shared.keyWindow?.rootViewController
                //                let alertVc = UIAlertController(title: "登录已经过期,请重新登录", message: nil, preferredStyle: .alert)
                //                alertVc.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                //                    LoginService.default.logout()
                //                    UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: LoginViewController())
                //                }))
                //                alertVc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                //                rootVc?.present(alertVc, animated: true, completion: nil)
                break
            }
            
            throw error
        })
    }
}
