//
//  LLPayUtils.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/22.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLPayUtils: NSObject {
    
    private override init() {
        super.init()
    }
    static let `default` = LLPayUtils()
    
    typealias ResultBack = (_ result: LLPayResultType) -> Void
    private var resultHandle: ((_ result: LLPayResultType) -> Void)?
    private var wxRegistID = ""
    
    class func registerWXApp(withAppRegistID registID: String) {
        
        self.default.wxRegistID = registID
        let wxRegisterFlag = WXApi.registerApp(registID, universalLink: "https://www.carisok.com/icar/")
        if wxRegisterFlag == false {
            print("*****:微信注册失败！")
        }
    }
    
    func handleOpen(url: URL) {
        WXApi.handleOpen(url, delegate: self)
    }
    
    func handleOpenUniversalLink(userActivity: NSUserActivity) -> Bool {
        WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }
    
    class func openWX(withDict dict: [String: Any], resultBack: @escaping ResultBack) {
        
        self.default.resultHandle = resultBack
        
        // 转模型
        let data = (try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))) ?? Data()
        let decoder = JSONDecoder()
        let WXreserved = try? decoder.decode(LLWXPayOrderInfo.self, from: data)

        let req = PayReq()
        req.openID = self.default.wxRegistID
        req.partnerId = WXreserved?.partnerId ?? ""
        req.prepayId = WXreserved?.prepayId ?? ""
        req.nonceStr = WXreserved?.nonceStr ?? ""
        req.timeStamp = UInt32((WXreserved?.timeStamp ?? ""))!
        req.package = WXreserved?.packageValue ?? ""
        req.sign = WXreserved?.sign ?? ""

        WXApi.send(req)

//        PaytoolManager.sharedPayInfo()?.appId = CRPayHelper.default.CRWXappId
//        let registerSuccess = WXApi.registerApp(CRPayHelper.default.CRWXappId, withDescription: CRPayHelper.default.CRWXDesc)
//        if registerSuccess == true {
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
//                WXApi.send(req)
//            })
//        } else {
//            print("微信支付注册失败")
//        }
    }

}

extension LLPayUtils: WXApiDelegate {
    
    func onResp(_ resp: BaseResp) {

        // 向微信请求授权后,得到响应结果
        if resp.isKind(of: SendAuthResp.self) {
            let tempResponse = resp as! SendAuthResp
//            print(tempResponse.errCode)
            switch tempResponse.errCode {
            case 0:
//                // 验证是否登录，没有登录则为微信授权登录，登录成功后则为微信换绑
//                if let code = tempResponse.code {
//                    switch WechatUtils.loginType {
//                    case .login:
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFY_WECHAT_LOGIN), object: code)
//                        break
//                    case .bind:
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFY_WECHAT_BIND), object: code)
//                        break
//                    case .changeBind:
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFY_WECHAT_CHANGE_BIND), object: code)
//                        break
//                    default: break
//                    }
//
//                } else {
//                    OYUtils.showWindowsToast(message: "您的网络有问题哦，授权失败")
//                }

                break
                
            case -2: // 取消
//                OYUtils.showWindowsToast(message: "微信登录失败")
                break
            case -4: // 拒绝
//                print("拒绝")
//                OYUtils.showWindowsToast(message: "微信登录失败")
                break
            default:
//                OYUtils.showWindowsToast(message: "您的网络有问题哦，授权失败")
                break
            }
            
        } else if resp.isKind(of: PayResp.self) {
            let tempResponse = resp as! PayResp
            if tempResponse.errCode == 0 { // 微信支付成功
                if let resultHandle = self.resultHandle {
                    resultHandle(.success)
                }
            } else if tempResponse.errCode == -2 { // 取消微信支付
                if let resultHandle = self.resultHandle {
                    resultHandle(.cancel)
                }
            } else {
                if let resultHandle = self.resultHandle {
                    resultHandle(.fail)
                }
            }
//            WeChatPaymanager.handlePayResultWidthCode(tempResponse.errCode, errorMsg: tempResponse.errStr)
//            print("***\(tempResponse.returnKey) \(tempResponse.errCode)")
        }
    }
}

