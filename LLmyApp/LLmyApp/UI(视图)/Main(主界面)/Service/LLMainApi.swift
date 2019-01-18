//
//  LLMainApi.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

enum LLMainApi {
    //获取滚动广告图接口
    case getAdvertisement()
}

extension LLMainApi: Requestable {

    var parameters: [String: Any]? {
        return nil
    }

    var path: String {
        return "advertisement/getAdvertisement"
    }

    var method: Method {
        return .get
    }

}
