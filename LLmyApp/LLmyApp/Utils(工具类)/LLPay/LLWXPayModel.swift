//
//  LLWXPayModel.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/22.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

struct LLWXPayModel: Codable {
    
    public var order_id: String?
    
    public var trade_id: String?
    
    public var notify_url: String?

    public var order_info: LLWXPayOrderInfo?
}

struct LLWXPayOrderInfo: Codable {
    
    public var timeStamp: String?
    
    public var packageValue: String?
    
    public var appId: String?
    
    public var sign: String?
    
    public var partnerId: String?
    
    public var prepayId: String?
    
    public var nonceStr: String?

}
