//
//  NewOrder.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/26/20.
//

import SwiftUI
import CoreData

final class LiteratureRequestDraft: ObservableObject {
    
    @Published var date = Date()
    
    @Published var isRecurring = false
    
    @Published var recipient = String()
    
//    @Published var orders = [OrderDraft]()
    
    
    func commit(context: NSManagedObjectContext) {
        let request = LiteratureRequest(context: context)
        
        request.date = date
        request.recipient = recipient
        request.isRecurring = isRecurring
        
        PersistenceController.save(context)
    }
    
}

//final class OrderDraft: ObservableObject {
//
//    @Published var quantity = 1
//
//    @Published var literatureItem: LiteratureItem?
//
////    var interval: Int {
////        Int(literatureItem?.category?.quantityPerGrouping ?? 1)
////    }
//
//    func managedObject(context: NSManagedObjectContext) -> LiteratureRequest {
//        let request = LiteratureRequest(context: context)
//
//        let order = LiteratureOrder(context: context)
//
//        order.quantity = Int32(quantity)
//        order.item = literatureItem!
//
//        request.orders.append(order)
//
//        return request
//    }
//
//}
