//
//  LiteratureRequest+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/11/20.
//
//

import Foundation
import CoreData


extension LiteratureRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiteratureRequest> {
        return NSFetchRequest<LiteratureRequest>(entityName: "LiteratureRequest")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isRecurring: Bool
    @NSManaged public var recipient: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension LiteratureRequest {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: LiteratureRequestItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: LiteratureRequestItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
