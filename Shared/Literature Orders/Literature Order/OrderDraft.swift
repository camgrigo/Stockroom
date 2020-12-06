//
//  NewOrder.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/26/20.
//

import SwiftUI
import CoreData

final class OrderDraft: ObservableObject {
    
    @Published var date = Date()
    
    @Published var quantity = 1
    
    @Published var literatureItem: LiteratureItem?
    
    var interval: Int {
        Int(literatureItem?.category?.quantityPerGrouping ?? 1)
    }
    
    @Published var recipient = String()
    
    @Published var isRecurring = false
    
    var isValid: Bool { literatureItem != nil }
    
    
    func managedObject(context: NSManagedObjectContext) -> LiteratureOrder {
        let order = LiteratureOrder(context: context)
        
        order.date = date
        order.item = literatureItem!
        order.quantity = Int32(quantity)
        order.recipient = recipient
        
        return order
    }
    
}
