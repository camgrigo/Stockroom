//
//  NewOrder.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/26/20.
//

import SwiftUI
import CoreData

final class LiteratureRequestDraft: ObservableObject, Identifiable {
    
    @Published var date = Date()
    
    @Published var isRecurring = false
    
    @Published var recipient = String()
    
    @Published var items = [
        RequestItemDraft()
    ]
    
    
//    func commit(context: NSManagedObjectContext) {
//        let request = LiteratureRequest(context: context)
//        
//        request.date = date
//        request.recipient = recipient
//        request.isRecurring = isRecurring
//        
//        PersistenceController.save(context)
//    }
    
}

final class RequestItemDraft: ObservableObject, Identifiable {

    @Published var quantity = 1

    @Published var literatureItem: LiteratureItem?
    
    
//    func commit(context: NSManagedObjectContext) {
//        let request = LiteratureRequest(context: context)
//
//        let order = LiteratureRequestItem(context: context)
//
//        order.quantity = Int32(quantity)
//        order.item = literatureItem!
//
//        request.items.append(order)
//
//        PersistenceController.save(context)
//    }
    
}
