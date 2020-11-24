//
//  Fish+CoreDataProperties.swift
//  
//
//  Created by 陈耀林 on 2020/10/29.
//
//

import Foundation
import CoreData

extension Fish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fish> {
        return NSFetchRequest<Fish>(entityName: "Fish")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32
    @NSManaged public var loveFood: String?

}
