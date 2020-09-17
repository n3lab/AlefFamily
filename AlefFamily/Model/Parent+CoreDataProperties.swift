//
//  Parent+CoreDataProperties.swift
//  AlefFamily
//
//  Created by n3deep on 16.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//
//

import Foundation
import CoreData


extension Parent {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Parent> {
        return NSFetchRequest<Parent>(entityName: "Parent")
    }

    @NSManaged public var age: Int16
    @NSManaged public var middleName: String?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var children: NSSet?

}

// MARK: Generated accessors for children
extension Parent {

    @objc(addChildrenObject:)
    @NSManaged public func addToChildren(_ value: Child)

    @objc(removeChildrenObject:)
    @NSManaged public func removeFromChildren(_ value: Child)

    @objc(addChildren:)
    @NSManaged public func addToChildren(_ values: NSSet)

    @objc(removeChildren:)
    @NSManaged public func removeFromChildren(_ values: NSSet)

}
