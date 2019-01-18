//
//  LLMainBanner.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/9.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit
import HandyJSON

class MainBanner: Modelable, Codable {
    
    var title: String?
    var shareTitle: String?
    
}

class TestBanner: Modelable, Codable {
    var title: String?
    
}

class LLMainBanner: HandyJSON {
    
    var name: String?
    var id: String?
    var lists: [Banner]?
    
    required init() {} // 如果定义是struct，连init()函数都不用声明；
    
}

class Banner: HandyJSON {
    var title: String?
    required init() {} // 如果定义是struct，连init()函数都不用声明；
}
