//
//  Delivery+CoreDataProperties.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/22/20.
//
//

import Foundation
import CoreData


extension Delivery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Delivery> {
        return NSFetchRequest<Delivery>(entityName: "Delivery")
    }

    @NSManaged public var carrier: String?
    @NSManaged public var requestItems: LiteratureRequestItem?

}
