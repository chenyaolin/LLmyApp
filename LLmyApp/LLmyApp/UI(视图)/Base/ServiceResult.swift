//
//  ServiceResult.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import RxSwift
import RxCocoa

struct ServiceResult<T: Codable>: Codable {
    
    /// 返回码
    var errorCode: String?
    /// 返回描述
    var errorMsg: String = "访问错误"
    
    var obj: AnyObject = "" as AnyObject
    
    /// 是否成功
    var result: Bool {
        guard resultInt == 1 else {
            return false
        }
        return true
    }
    /// 数据实体
    var content: T?
    
    var resultInt: Int?
    
    enum CodingKeys: String, CodingKey {
        case errorCode
        case errorMsg
        case resultInt = "result"
        case content = "busObj"
    }
    
    init() {
        
    }
    
    init(errorMessage: String) {
        self.errorMsg = errorMessage
    }
    
    //    init(inquiry: InquiryResult<T>) {
    //        self.resultMessage = inquiry.errorMessage
    //        self.content = inquiry.data
    //        self.successInt = inquiry.result
    //        self.resultCode = "\(inquiry.errorCode)"
    //    }
    
}

extension ObservableType where Element: Response {
    
    // 使用HandyJSON来转模型
    func mapModel <T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
    
    // 使用Codable原生协议来转模型(swift 4.0才支持)
    func ServiceResultMap<T: Codable>(_ type: T.Type) -> Observable<ServiceResult<T>> {
        return flatMap({ (response) in
            return Observable.just(try response.serviceResultMap(T.self))
        })
    }
    
}

extension Response {
    
    // 使用HandyJSON来转模型
    func mapModel <T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
    
    // 使用Codable原生协议来转模型(swift 4.0才支持)
    func serviceResultMap<T: Codable>(_ type: T.Type) throws -> ServiceResult<T> {
        
        let object: ServiceResult<T>
        
        do {
            let decoder = JSONDecoder()
            object = try decoder.decode(ServiceResult<T>.self, from: data)
            if object.resultInt == 0 {
                HUDHelper.show(message: object.errorMsg, duration: 3)
//                throw ServiceError.objectMap
            }
        } catch {
            print(error)
            throw ServiceError.objectMap
        }
        
        return object
    }
    
}
