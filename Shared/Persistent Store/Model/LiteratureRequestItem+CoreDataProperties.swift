//
//  LiteratureRequestItem+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/11/20.
//
//

import Foundation
import CoreData


extension LiteratureRequestItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiteratureRequestItem> {
        return NSFetchRequest<LiteratureRequestItem>(entityName: "LiteratureRequestItem")
    }

    @NSManaged public var quantity: Int32
    @NSManaged public var item: LiteratureItem?
    @NSManaged public var request: LiteratureRequest?
    @NSManaged public var delivery: Delivery?

}
