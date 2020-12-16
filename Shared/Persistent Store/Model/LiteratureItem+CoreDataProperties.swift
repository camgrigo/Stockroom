//
//  LiteratureItem+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/15/20.
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
    @NSManaged public var category: LiteratureItemCategory?
    @NSManaged public var reqsuestItems: NSSet?
    @NSManaged public var shipmentItems: ShipmentItem?

}

// MARK: Generated accessors for reqsuestItems
extension LiteratureItem {

    @objc(addReqsuestItemsObject:)
    @NSManaged public func addToReqsuestItems(_ value: LiteratureRequestItem)

    @objc(removeReqsuestItemsObject:)
    @NSManaged public func removeFromReqsuestItems(_ value: LiteratureRequestItem)

    @objc(addReqsuestItems:)
    @NSManaged public func addToReqsuestItems(_ values: NSSet)

    @objc(removeReqsuestItems:)
    @NSManaged public func removeFromReqsuestItems(_ values: NSSet)

}

extension LiteratureItem : Identifiable {

}
