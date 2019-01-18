//
//  LLHealthCardApi.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

enum LLHealthCardApi {
    case getECardNoInfo(patId: String)
}

extension LLHealthCardApi: Requestable {
    
    var parameters: [String: Any]? {
        switch self {
        case .getECardNoInfo(let patId):
////            return ["patId": patId]
//            print("\(patId)")
//            return nil
            return ["contactPhone": "13800138000",
                    "vcode": "e10adc3949ba59abbe56e057f20f883e"]
        }
    }
    
    var path: String {
//        switch self {
//        case .getECardNoInfo(let patId):
//            return "patRelatives/getECardNoInfo\(/patId)"
//        }
        return "login/loginPatVcode"
    }
    
    var method: Method {
//        return .get
        return .post
    }
    
}
