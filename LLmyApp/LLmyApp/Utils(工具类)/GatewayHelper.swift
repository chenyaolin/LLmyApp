//
//  GatewayHelper.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/12.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift
import RxCocoa
import HandyJSON

private let clientName = "patientApp"
private let clientCredential = "74B751BF5CA54526AFB82AA467852976"
//private let crRandom = String.randomStr(len: 32)

class GatewayError: HandyJSON {
    
    var returnCode: Int?
    required init() {} // 如果定义是struct，连init()函数都不用声明；
    
}

class GatewayData: HandyJSON {
    
    var accessToken: String?
    var refreshToken: String?
    var returnCode: Int?
    
    required init() {} // 如果定义是struct，连init()函数都不用声明；
    
}

class GatewayHelper: NSObject {
    
    // 单例
    static let `default` = GatewayHelper()
    var sign = ""
    var accessToken = ""
    var refreshToken = ""
    let disposeBag = DisposeBag()
    let crRandom = String.randomStr(len: 32)
    
    class func requestCRAPIGatewayAccessToken(withErrorCode errorCode: Int, _ selectedBack: (() -> Void)?) {
        
        switch errorCode {
        //-1assessToken未发现  -5refreshToken过期 -6refreshToken不合法
        case -1, -5, -6:
            getGatewayAccessToken {
                if let selectedBack = selectedBack {
                    selectedBack()
                }
            }
        //-2不合法 -3assessToken过期
        case -2, -3:
            getGatewayRefreshToken {
                if let selectedBack = selectedBack {
                    selectedBack()
                }
            }
        default:
            print("请求错误")
        }
        
    }
    
    // 获取accessToken
    class func getGatewayAccessToken(_ selectedBack: (() -> Void)?) {
        
        GatewayHelper.default.sign = clientName + "&" + clientCredential + "&" + GatewayHelper.default.crRandom
        GatewayHelper.default.sign = String.md5(strs: GatewayHelper.default.sign)
        
        let privoder = MoyaProvider<GatewayApi>()
        privoder.rx.request(.gatewayAccessToken).asObservable().mapModel(GatewayData.self).subscribe(onNext: { (value) in
            
            GatewayHelper.default.accessToken = value.accessToken ?? ""
            GatewayHelper.default.refreshToken = value.refreshToken ?? ""
            if let selectedBack = selectedBack {
                selectedBack()
            }
            
        }).disposed(by: GatewayHelper.default.disposeBag)
        
    }
    
    // 获取refreshToken
    class func getGatewayRefreshToken(_ selectedBack: (() -> Void)?) {
        
        let privoder = MoyaProvider<GatewayApi>()
        privoder.rx.request(.getewayRefreshToken).asObservable().mapModel(GatewayData.self).subscribe(onNext: { (value) in
            
            GatewayHelper.default.accessToken = value.accessToken ?? ""
            GatewayHelper.default.refreshToken = value.refreshToken ?? ""
            if let selectedBack = selectedBack {
                selectedBack()
            }
            
        }).disposed(by: GatewayHelper.default.disposeBag)
        
    }
    
}

enum GatewayApi {
    case gatewayAccessToken
    case getewayRefreshToken
}

extension GatewayApi: TargetType {
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var path: String {
        return "/"
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    public var method: Method {
        return .get
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .gatewayAccessToken:
            return ["CR-Grant-Type": "apply_token",
                    "CR-Client-Name": "patientApp",
                    "CR-Random": GatewayHelper.default.crRandom,
                    "CR-Sign": GatewayHelper.default.sign]
        case .getewayRefreshToken:
            return ["CR-Grant-Type": "refresh_token",
                    "CR-Refresh-Token": GatewayHelper.default.refreshToken]
        }
        
    }
    
}
