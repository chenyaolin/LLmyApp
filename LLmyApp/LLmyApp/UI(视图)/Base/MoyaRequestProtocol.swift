//
//  LLMoyaRequestProtocol.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import Moya

typealias Method = Moya.Method
typealias Task = Moya.Task
typealias MultipartFormData = Moya.MultipartFormData
typealias URLEncoding = Moya.URLEncoding
typealias JSONEncoding = Moya.JSONEncoding

protocol Requestable: TargetType {
    var parameters: [String: Any]? {get}
    var method: Method {get}
}

extension Requestable {
    
    public var sampleData: Data {
        return Data()
    }
    
    public var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    public var method: Method {
        return .post
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: method == .post ? JSONEncoding.default : URLEncoding.default)
    }
    
    var headers: [String: String]? {
        //        if let accessToken = UserDefaults.LoginInfo.accessToken.value(type: String.self) {
        //            return ["fu-access-token": accessToken]
        //        }
        //        return nil
        print("这是token: \(GatewayHelper.default.accessToken)")
        return ["CR-Access-Token": GatewayHelper.default.accessToken]
    }
    
}
