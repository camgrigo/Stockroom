//
//  Shipment+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/11/20.
//
//

import Foundation
import CoreData


extension Shipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shipment> {
        return NSFetchRequest<Shipment>(entityName: "Shipment")
    }

    @NSManaged public var trackingNumber: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Shipment {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ShipmentItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ShipmentItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
