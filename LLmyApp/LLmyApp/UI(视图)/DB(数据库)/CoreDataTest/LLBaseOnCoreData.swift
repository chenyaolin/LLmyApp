//
//  LLBaseOnCoreData.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2020/10/30.
//  Copyright © 2020 ManlyCamera. All rights reserved.
//

import Foundation
import CoreData

protocol LLBaseOnCoreData: Equatable {
    
    associatedtype Content
    
    func saveConText(by info: Content)
    
}

extension LLBaseOnCoreData where Self : NSManagedObject {
    
    @discardableResult
    static func createInfo(_ info: Content, context: NSManagedObjectContext) -> Self {
        
        let t = Self.init(context: context)
        t.saveConText(by: info)
        return t
    }
    
    @discardableResult
    static func createMemory(inMemory info: Content) -> Self {
        return createInfo(info, context: LLDBManager.default.inMemoryContext)
    }
}
