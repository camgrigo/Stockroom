//
//  LiteratureItem+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/22/20.
//
//

import Foundation
import CoreData


extension LiteratureItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiteratureItem> {
        return NSFetchRequest<LiteratureItem>(entityName: "LiteratureItem")
    }

    @NSManaged public var colorData: Data?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var symbol: String?
    @NSManaged public var title: String?
    @NSManaged public var language: String?
    @NSManaged public var category: LiteratureItemCategory?
    @NSManaged public var requestItems: NSSet?
    @NSManaged public var shipmentItems: ShipmentItem?

}

// MARK: Generated accessors for requestItems
extension LiteratureItem {

    @objc(addRequestItemsObject:)
    @NSManaged public func addToRequestItems(_ value: LiteratureRequestItem)

    @objc(removeRequestItemsObject:)
    @NSManaged public func removeFromRequestItems(_ value: LiteratureRequestItem)

    @objc(addRequestItems:)
    @NSManaged public func addToRequestItems(_ values: NSSet)

    @objc(removeRequestItems:)
    @NSManaged public func removeFromRequestItems(_ values: NSSet)

}
