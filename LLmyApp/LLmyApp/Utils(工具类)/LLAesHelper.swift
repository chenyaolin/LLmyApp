//
//  LLAesHelper.swift
//  LLmyApp
//
//  Created by 陈林 on 2023/8/8.
//  Copyright © 2023 ManlyCamera. All rights reserved.
//

import UIKit
import CryptoSwift

class LLAesHelper: NSObject {
    
    static func aesDecrypt(ciphertext: String, key: String, iv: String) throws -> String {
        
        let data = Data(base64Encoded: ciphertext)!
        let aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
        let decrypted = try aes.decrypt(data.bytes)
        
        return String(data: Data(decrypted), encoding: .utf8)!
    }
    
    static func test() {
        let ciphertext = "SsJDndIlcxXzTTL1yZ91LVymetZ/mCmRFe9e3YxdWGX81nUGJGb/+mQ1k3WygXhYCA7tFQ7nnzj4A7lZW4As1g=="
        let key = "QwEr12TyUi!@Op34AsDf#$GhJk56L%^Z"
        let iv = "xCvB78Nm&*9(0)Mn"

        do {
            let decryptedText = try self.aesDecrypt(ciphertext: ciphertext, key: key, iv: iv)
            print("Decrypted Text: \(decryptedText)")
        } catch {
            print("Error: \(error)")
        }
    }

}
