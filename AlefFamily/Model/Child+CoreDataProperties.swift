//
//  Child+CoreDataProperties.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var parent: Parent?

}
