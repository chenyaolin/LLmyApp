//
//  Commons.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/8.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

// MARK: 服务器根地址
#if DEBUG
//let kBaseURL = "http://120.24.63.55:8089/crPatient/cxf/rest/"  // 测试地址
let kBaseURL = "https://api.cr-health.com:9443/crPatient/cxf/rest"  // 生产环境地址
#else
let kBaseURL = "https://api.cr-health.com:9443/crPatient/cxf/rest/"  // 生产环境地址
#endif

// MARK: - 设备相关
let kMainBounds = UIScreen.main.bounds
var kAppHeight: CGFloat { return UIScreen.main.bounds.size.height }
var kAppWidth: CGFloat { return UIScreen.main.bounds.size.width }
let kNavgationHeight: CGFloat = 64
let kTabBarHeight: CGFloat = 49
var kAppSafeTop: CGFloat = 20
var kAppSafeBottom: CGFloat = 0

let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

// MARK: - 颜色
let kContentDefaultColor = UIColor(hex: "#575B6E")
let LLdefaultGreenColor = UIColor(hex: "#40BB90")
let kNavigationColor = UIColor(hex: "#FFFFFF")
let kBaseViewBackgroundColor = UIColor(hex: "#F8F8F8")
let kBlueButtonBackgroundColor = UIColor(hex: "#3EB2FF")
let kMainTitleColor = UIColor(hex: "#030303")
let kSeparatorColor = UIColor(hex: "#EEEEEE")
let LLlightContextColor = UIColor(hex: "#999999")
