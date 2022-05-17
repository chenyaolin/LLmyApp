//
//  LLHealthCardModel.swift
//  LLmyApp
//
//  Created by chenyaolin on 2018/11/14.
//  Copyright © 2018年 LinChen. All rights reserved.
//

import UIKit

class CRUserInfo: Modelable, Codable {
    public var name: String?
    public var nickName: String?
}

class CRHealthCard: Modelable, Codable {
    
    /** 亲属表ID */
    public var id: Int?
    /** 就诊人姓名 */
    public var name: String?
    /** 身份证号 */
    public var idNo: String?
    /** 激活状态，0:未激活，1:已激活 */
    public var state: CRHealthCardState?
    /** 激活时间 (月/年) */
    public var activationTime: String?
    /** 健康卡号 */
    public var eCardNo: String?
    
}

enum CRHealthCardState: String, Modelable, Codable {
    // 未激活
    case notActive = "0"
    // 已激活
    case activated = "1"
}

