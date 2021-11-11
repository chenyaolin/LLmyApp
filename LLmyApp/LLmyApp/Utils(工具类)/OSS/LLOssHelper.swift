//
//  LLOssHelper.swift
//  LLmyApp
//
//  Created by chenyaolin on 2021/10/20.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit
import AliyunOSSiOS

class LLOssHelper: NSObject {
    
    // 单例
    static let `share` = LLOssHelper()
    
    var ossClient: OSSClient!
    
    static func uploadImageOSS() {
        
//        let request = OSSPutObjectRequest()
        let request = OSSGetObjectRequest()
//        request.bucketName = FCConstant.DomainName.ossBucket
//        request.objectKey = key
//        request.uploadingData = data
        
        let task = LLOssHelper.share.ossClient.getObject(request)
        task.continue({ (task) -> Any? in
            if task.error == nil {
            } else {
            }
            return nil
        })
        
//        return request
    }

}
