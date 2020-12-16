//
//  ShipmentItem+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/11/20.
//
//

import Foundation
import CoreData


extension ShipmentItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShipmentItem> {
        return NSFetchRequest<ShipmentItem>(entityName: "ShipmentItem")
    }

    @NSManaged public var quantity: Int32
    @NSManaged public var shipment: Shipment?
    @NSManaged public var item: LiteratureItem?

}
