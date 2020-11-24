//
//  LLFish+.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2020/10/30.
//  Copyright © 2020 ManlyCamera. All rights reserved.
//

import Foundation
import CoreData

struct MyFishModel: Codable {
    
    var t_name: String?
    var t_loveFood: String?
    var t_age: Int32?
    
    init(t_name: String, t_loveFood: String, t_age: Int32) {
        self.t_name = t_name
        self.t_loveFood = t_loveFood
        self.t_age = t_age
    }
    
}

extension Fish {
    
}

extension Fish: LLBaseOnCoreData {
    
    typealias Content = MyFishModel
    
    func saveConText(by info: MyFishModel) {
        self.age = info.t_age ?? 0
        self.loveFood = info.t_loveFood
        self.name = info.t_name
    }
    
    static func create(_ info: Content, context: NSManagedObjectContext) {
        
        let request = fetchRequest() as NSFetchRequest<Fish>
        
        do {
            
            let result = try context.fetch(request)
            
            var index = 0
            for item in result {
                if item.age == 1 {
                    
                    let r = result[index]
                    
                    // 改
                    let info1 = MyFishModel(t_name: "小鱼仔", t_loveFood: "鱼", t_age: 13)
                    r.saveConText(by: info1)
                    
                    /// 删除
                    context.delete(r)
                }
                index += 1
            }
            
//            let resource = result.first ?? StResource(context: context)
            // 查找数据库更改
//            let resource = result.first ?? Fish(context: context)
            // 新增一条数据
            let resource = Fish(context: context)
            
            resource.saveConText(by: info)
            
            print("111111 数据保存成功")
            
//            return resource
            
        } catch {
            
        print("111111 数据保存失败")
            
//            Logging(error.localizedDescription)
            
//            Logging((error as NSError).userInfo.description)
            
//            let resource = Fish(context: context)
//
//            resource.saveConText(by: info)
            
//            return resource
        }
        
    }
}
