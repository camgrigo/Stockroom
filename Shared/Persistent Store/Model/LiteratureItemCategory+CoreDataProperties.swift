//
//  LiteratureItemCategory+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/11/20.
//
//

import Foundation
import CoreData


extension LiteratureItemCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiteratureItemCategory> {
        return NSFetchRequest<LiteratureItemCategory>(entityName: "LiteratureItemCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantityPerGrouping: Int32
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension LiteratureItemCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: LiteratureItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: LiteratureItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
