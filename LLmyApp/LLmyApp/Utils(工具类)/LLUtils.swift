//
//  LLUtils.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/21.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLUtils: NSObject {

    class func dataModel<T: Codable>(_ jsonFileName: String, type: T.Type) -> T? {
        let path = Bundle.main.path(forResource: jsonFileName, ofType: "json")
        var jsonStr: String? = nil
        do {
            jsonStr = try String(contentsOfFile: path ?? "", encoding: .utf8)
        } catch {
        }
        if let jsonData = jsonStr?.data(using: .utf8) {
            return jsonData.decode(type.self)
        }
        return type.self as? T
    }
    
}

extension Data {
    func decode<T: Codable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        return (try? decoder.decode(type.self, from: self))
    }
}
